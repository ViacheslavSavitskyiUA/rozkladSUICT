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
    
    @Published var rozkladListViewModel: RozkladListViewModel! = .init(days: [])
    
    private let network = NetworkManager()
    
    private let searchId: Int
    private let type: UserType
    
    init(searchId: Int, type: UserType) {
        self.searchId = searchId
        self.type = type
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
                rozkladListViewModel.days = rozklad
            } catch {
                print(error)
            }
            
        case .teacher:
            do {
                let models = try await network.getRozklad(teacherId: searchId,
                                                          dateStart: transformDateString().start,
                                                          dateEnd: transformDateString().end).get()
                await transformRozklad(models: models)
                rozkladListViewModel.days = rozklad
            }  catch {
                print(error)
            }
        case .unowned: ()
        }
    }
    
    func transformDateString() -> (start: String, end: String) {
        let dates = Date().getCurrentWeekDays()
        
        let start = Transform.transformDateToString(date: dates.first ?? .now, dateFormat: .yyyyMMdd)
        let end = Transform.transformDateToString(date: dates.last ?? .now, dateFormat: .yyyyMMdd)
        return (start: start, end: end)
    }
    
    func transformRozklad(models: [RozkladModel]) async {
//        переделать трансформацию розклада
//        var rozkladObject: RozkladEntity?
//        
//        for model in models {
//            rozkladObject?.date = model.date
//            for lesson in model.lessons {
//                rozkladObject?.lessons.append(LessonEntity(lessonNumber: lesson.number,
//                                                disciplineFullName: lesson.periods.first?.disciplineFullName ?? "",
//                                                disciplineShortName: lesson.periods.first?.disciplineShortName ?? "",
//                                                classroom: lesson.periods.first?.classroom ?? "",
//                                                timeStart: lesson.periods.first?.timeStart ?? "",
//                                                timeEnd: lesson.periods.first?.timeEnd ?? "",
//                                                teachersName: lesson.periods.first?.teachersName ?? "",
//                                                teachersNameFull: lesson.periods.first?.teachersNameFull ?? "",
//                                                groups: lesson.periods.first?.groups ?? "",
//                                                type: lesson.periods.first?.type ?? 0,
//                                                typeStr: lesson.periods.first?.typeStr ?? ""))
//            }
//            guard let roz = rozkladObject else { return }
//            rozklad.append(roz)
//            rozkladObject = nil
//        }
    }
}
