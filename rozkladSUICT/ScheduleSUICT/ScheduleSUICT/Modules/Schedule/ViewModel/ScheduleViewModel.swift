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
    
//    @Published var rozkladListViewModel: RozkladListViewModel! {
//        didSet {
//            print("rozkladListViewModel \(rozkladListViewModel)")
//        }
//    }
//    @Published var dayCollectionViewModel: DayCollectionViewModel! {
//        didSet {
//            print("dayCollectionViewModel \(dayCollectionViewModel)")
//        }
//    }
    
    @Published var isShowLoader = false
    private var isShowErrorView = false
    
    @Published var navigationTitle: String
    
//    @Published var selectDay: RozkladEntity = .init()
    
    @Published var isShowSaveAlert: Bool = false
    
    @Published var userDataStatus: UserDataStatus = .unsaved
    
    let network = NetworkManager()
    @Published var rozklad: [RozkladEntity] = []
    private var days: [DayEntity] = []
    
    private let searchId: Int
    let type: UserType
    
    var notificationService: NotificationService
    
    init(searchId: Int, type: UserType, title: String) {
        self.searchId = searchId
        self.type = type
        self.navigationTitle = title
        
        if type == .auditory {
            self.navigationTitle = "\(title) аудиторія"
        }
        
        notificationService = NotificationService()
    }
    
    func saveUserData() {
        notificationService.scheduleNotifications(models: rozklad,
                                                  userType: type)
        
        StorageService.storageId(searchId)
        StorageService.storageType(type.rawValue)
        StorageService.storageTitle(navigationTitle)
        
        userDataStatus = .saved
    }
    
    func unsaveUserData() {
        StorageService.storageId(nil)
        StorageService.storageType(nil)
        StorageService.storageTitle(nil)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        userDataStatus = .unsaved
    }
    
    func checkReturnSaveImage() -> String {
        if userDataStatus == .saved  {
            return "star.fill"
        } else {
            return "star"
        }
    }
    
    func askedSaveQuestion() {
        if StorageService.readStorageTitle() != self.navigationTitle &&
            StorageService.readStorageId() != searchId &&
            StorageService.readStorageType() != type {
            withAnimation {
                isShowSaveAlert = true
            }
        }
    }
    
    @MainActor
    func transformRangeDateString() -> (start: String, end: String) {
        let dates = Date().getCurrentWeekDays()
        
        let start = Transform.transformDateToString(date: dates.first ?? .now, dateFormat: .yyyyMMdd)
        let end = Transform.transformDateToString(date: dates.last ?? .now, dateFormat: .yyyyMMdd)
        return (start: start, end: end)
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
                              teachersNameFull: period.teachersNameFull,
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

