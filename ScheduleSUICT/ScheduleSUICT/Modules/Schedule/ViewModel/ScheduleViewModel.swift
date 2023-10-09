//
//  ScheduleViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import Combine
import Foundation

final class ScheduleViewModel: ObservableObject {
    
    @Published var rozklad: [RozkladEntity] = []
    
    @Published var rozkladListViewModel: RozkladListViewModel = .init(days: [])
    @Published var dayCollectionViewModel: DayCollectionViewModel = .init()
    
    private let network = NetworkManager()
    
    @Published var isShowLoader = false
    @Published var navigationTitle: String
    
    private let searchId: Int
    private let type: UserType
    
    init(searchId: Int, type: UserType, title: String) {
        self.searchId = searchId
        self.type = type
        self.navigationTitle = title
    }
    
    @MainActor
    func fetchRozklad() async {
        switch type {
        case .student:
            do {
                let models = try await network.getRozklad(groupId: searchId,
                                                          dateStart: transformDateString().start,
                                                          dateEnd: transformDateString().end).get()
                await transformRozklad(models: models)
            } catch {
                print(error)
            }
            
        case .teacher:
            do {
                let models = try await network.getRozklad(teacherId: searchId,
                                                          dateStart: transformDateString().start,
                                                          dateEnd: transformDateString().end).get()
                await transformRozklad(models: models)
            }  catch {
                print(error)
            }
        case .unowned: ()
        }
    }
    
    @MainActor
    func transformDateString() -> (start: String, end: String) {
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
                    rozkladObject.lessons.append(.init(lessonNumber: lesson.number,
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
        
        rozkladListViewModel.days = rozklad
    }
}
