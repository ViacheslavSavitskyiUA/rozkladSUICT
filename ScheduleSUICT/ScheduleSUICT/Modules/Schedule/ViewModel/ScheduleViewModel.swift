//
//  ScheduleViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import Combine
import Foundation
import SwiftUI

enum UserDataStatus {
    case saved, unsaved
}

final class ScheduleViewModel: ObservableObject {
    
    @Published var finalRozklad: [RozkladEntity] = []
    
    @Published var rozkladListViewModel: RozkladListViewModel!
    @Published var dayCollectionViewModel: DayCollectionViewModel!
    
    @Published var isShowLoader = false
    @Published var isShowErrorView = false
    
    @Published var navigationTitle: String
    
    @Published var selectDay: RozkladEntity = .init()
    
    @Published var isShowSaveAlert: Bool = false
    
    @Published var userDataStatus: UserDataStatus = .unsaved
    
    @Published var isShareSheetPresented: Bool = false
    
    private let network = NetworkManager()
    private var rozklad: [RozkladEntity] = []
    private var days: [DayEntity] = []
    
    private let searchId: Int
    let type: UserType
    
    init(searchId: Int, type: UserType, title: String) {
        self.searchId = searchId
        self.type = type
        self.navigationTitle = title
        
        if type == .auditory {
            self.navigationTitle = "\(title) аудиторія"
        }
        
        setupViewModels()
    }
    
    func setupView() {
        Task {
            await fetchRozklad()
            await setupDays()
        }
    }
    
    func activityText() -> String {
        var text = ""
        
        if selectDay.lessons.count == 0 {
            text = "\(navigationTitle)\n\(Transform.transformDateToString(date: Transform.transformStringToDate(selectDay.date, dateFormat: .yyyyMMdd), dateFormat: .ddMMyyyy))\nнемає занять"
        } else {
            text = "\(navigationTitle)\n\(Transform.transformDateToString(date: Transform.transformStringToDate(selectDay.date, dateFormat: .yyyyMMdd), dateFormat: .ddMMyyyy))\n\n"
            
            for lesson in selectDay.lessons {
                text.append("\(lesson.lessonNumber) пара \(lesson.timeStart)-\(lesson.timeEnd)")
                text.append("\n")
                text.append(lesson.disciplineShortName)
                text.append("\n")
                
                switch type {
                case .student:
                    text.append(lesson.teachersName)
                    text.append("\n")
                    text.append("\(lesson.classroom) ауд.")
                case .teacher:
                    text.append(lesson.groups)
                    text.append("\n")
                    text.append("\(lesson.classroom) ауд.")
                case .auditory:
                    text.append(lesson.groups)
                    text.append("\n")
                    text.append(lesson.teachersName)
                case .unowned: ()
                }
                
                text.append("\n\n")
            }
        }

        return text
    }
    
    func saveUserData() {
        StorageService.storageId(searchId)
        StorageService.storageType(type.rawValue)
        StorageService.storageTitle(navigationTitle)
        
        userDataStatus = .saved
    }
    
    func unsaveUserData() {
        StorageService.storageId(nil)
        StorageService.storageType(nil)
        StorageService.storageTitle(nil)
        
        userDataStatus = .unsaved
    }
    
    func checkReturnSaveImage() -> String {
        if StorageService.readStorageTitle() == self.navigationTitle &&
            StorageService.readStorageId() == searchId &&
            StorageService.readStorageType() == type  {
            return "star.fill"
        } else {
            return "star"
        }
    }
    
    private func askedSaveQuestion() {
        if StorageService.readStorageTitle() != self.navigationTitle &&
            StorageService.readStorageId() != searchId &&
            StorageService.readStorageType() != type {
            withAnimation {
                isShowSaveAlert = true
            }
        }
    }
    
    private func setupViewModels() {
        rozkladListViewModel = .init(lessons: [], type: type)
        
        dayCollectionViewModel = .init(completion: { rozklad in
            withAnimation(.easeIn) { [weak self] in
                guard let self = self else { return }
                self.selectDay = rozklad
                self.rozkladListViewModel.lessons = rozklad.lessons
                self.dayCollectionViewModel.day = rozklad
            }
        })
        
        if StorageService.readStorageId() == searchId
            && StorageService.readStorageType() == type
            && StorageService.readStorageTitle() == navigationTitle {
            userDataStatus = .saved
        } else {
            userDataStatus = .unsaved
        }
    }
    
    @MainActor
    func fetchRozklad() async {
        isShowLoader = true
        switch type {
        case .student:
            do {
                let models = try await network.getRozklad(groupId: searchId,
                                                          dateStart: transformRangeDateString().start,
                                                          dateEnd: transformRangeDateString().end).get()
                isShowErrorView = false
                await transformRozklad(models: models)
                askedSaveQuestion()
            } catch {
                isShowErrorView = true
            }
            
        case .teacher:
            do {
                let models = try await network.getRozklad(teacherId: searchId,
                                                          dateStart: transformRangeDateString().start,
                                                          dateEnd: transformRangeDateString().end).get()
                isShowErrorView = false
                await transformRozklad(models: models)
                askedSaveQuestion()
            } catch {
                isShowErrorView = true
            }
        case .auditory:
            do {
                let models = try await network.getRozklad(classroomId: searchId, dateStart: transformRangeDateString().start, dateEnd: transformRangeDateString().end).get()
                isShowErrorView = false
                await transformRozklad(models: models)
            } catch {
                isShowErrorView = true
            }
        default: ()
        }
        isShowLoader = false
    }
    
    @MainActor
    func transformRangeDateString() -> (start: String, end: String) {
        let dates = Date().getCurrentWeekDays()
        
        let start = Transform.transformDateToString(date: dates.first ?? .now, dateFormat: .yyyyMMdd)
        let end = Transform.transformDateToString(date: dates.last ?? .now, dateFormat: .yyyyMMdd)
        return (start: start, end: end)
    }
    
    @MainActor
    func setupDays() async {
        let dates = Date().getCurrentWeekDays()
        
        var datesString = [String]()
        var rozkladObject: RozkladEntity = .init()
        
        for date in dates {
            datesString.append(Transform.transformDateToString(date: date, dateFormat: .yyyyMMdd))
        }
        print("datesString \(datesString)")
        
        var haveDates: [String] = .init()
        var haventDates: [String] = .init()
        
        for d in datesString {
            if rozklad.contains(where: { $0.date == d }) {
                haveDates.append(d)
            } else {
                haventDates.append(d)
            }
        }
        print("haveDates \(haveDates)")
        print("haventDates \(haventDates)")
        
        for date in datesString {
            for r in rozklad {
                if date == r.date && haveDates.contains(r.date) {
                    rozkladObject.date = date
                    rozkladObject.dayWeek = Transform.transformDateToString(date: Transform.transformStringToDate(date, dateFormat: .yyyyMMdd), dateFormat: .eeee)
                    rozkladObject.isToday = Calendar.current.isDateInToday(Transform.transformStringToDate(date, dateFormat: .yyyyMMdd))
                    rozkladObject.isSelected = rozkladObject.isToday
                    
                    for lesson in r.lessons {
                        rozkladObject.lessons.append(
                            .init(lessonNumber: lesson.lessonNumber,
                                  disciplineFullName: lesson.disciplineFullName,
                                  disciplineShortName: lesson.disciplineShortName,
                                  classroom: lesson.classroom,
                                  timeStart: lesson.timeStart,
                                  timeEnd: lesson.timeEnd,
                                  teachersName: lesson.teachersName,
                                  teachersNameFull: lesson.teachersNameFull,
                                  groups: lesson.groups,
                                  type: lesson.type,
                                  typeStr: lesson.typeStr))
                    }
                    
                    if rozkladObject.isToday {
                        withAnimation(.easeIn) {
                            selectDay = rozkladObject
                            dayCollectionViewModel.day = rozkladObject
                            rozkladListViewModel.lessons = rozkladObject.lessons
                        }
                    }
                    
                } else if haventDates.contains(date) {
                    rozkladObject.date = date
                    rozkladObject.dayWeek = Transform.transformDateToString(date: Transform.transformStringToDate(date, dateFormat: .yyyyMMdd), dateFormat: .eeee)
                    rozkladObject.isEmpty = true
                    rozkladObject.lessons = []
                    rozkladObject.isToday = Calendar.current.isDateInToday(Transform.transformStringToDate(date, dateFormat: .yyyyMMdd))
                    rozkladObject.isSelected = rozkladObject.isToday
                    
                    if rozkladObject.isToday {
                        withAnimation(.easeIn) {
                            selectDay = rozkladObject
                            dayCollectionViewModel.day = rozkladObject
                            rozkladListViewModel.lessons = rozkladObject.lessons
                        }
                    }
                }
            }
            finalRozklad.append(rozkladObject)
            rozkladObject = .init()
        }
        
        dayCollectionViewModel.days = finalRozklad
    }
    
    @MainActor
    func transformRozklad(models: [RozkladModel]) async {
        var rozkladObject: RozkladEntity = .init()
        
        for model in models {
            rozkladObject.date = model.date
            for lesson in model.lessons {
                for period in lesson.periods {
                    rozkladObject.lessons.append(
                        .init(lessonNumber: lesson.number,
                              disciplineFullName: period.disciplineFullName,
                              disciplineShortName: period.disciplineShortName,
                              classroom: period.classroom,
                              timeStart: period.timeStart,
                              timeEnd: period.timeEnd,
                              teachersName: period.teachersName,
                              teachersNameFull: period.teachersName,
                              groups: period.groups,
                              type: period.type,
                              typeStr: period.typeStr))
                }
            }
            rozklad.append(rozkladObject)
            rozkladObject = .init()
        }
    }
}
