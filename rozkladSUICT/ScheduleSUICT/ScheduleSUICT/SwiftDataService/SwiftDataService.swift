//
//  SwiftDataService.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.12.2024.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SwiftDataService {
    
    func saveRozklad(schedule: [RozkladModel],context: ModelContext) {
        
        let fetchDescriptor = FetchDescriptor<MainRozkladSwiftDataModel>()
        do {
            let allTasks = try context.fetch(fetchDescriptor)
            for task in allTasks {
                context.delete(task)
            }
        } catch {
            print("bleat'")
        }
        
        
        var rozkladModel: [RozkladSwiftDataModel] = []
        
        for rozklad in schedule {
            
            var rozkladLessons: [LessonSwiftDataModel] = []
            for lesson in rozklad.lessons {
                
                var periods: [PeriodSwiftDataModel] = []
                
                for period in lesson.periods {
                    let per = PeriodSwiftDataModel(r1: period.r1,
                                                   rz14: period.rz14,
                                                   rz15: period.rz15,
                                                   disciplineID: period.disciplineID,
                                                   educationDisciplineID: period.educationDisciplineID,
                                                   disciplineFullName: period.disciplineFullName,
                                                   disciplineShortName: period.disciplineShortName,
                                                   classroom: period.classroom,
                                                   timeStart: period.timeStart,
                                                   timeEnd: period.timeEnd,
                                                   teachersName: period.teachersName,
                                                   teachersNameFull: period.teachersNameFull,
                                                   type: period.type,
                                                   typeStr: period.typeStr,
                                                   dateUpdated: period.dateUpdated,
                                                   nonstandardTime: period.nonstandardTime,
                                                   groups: period.groups,
                                                   extraText: period.extraText)
                    periods.append(per)
                }
                
                rozkladLessons.append(LessonSwiftDataModel(number: lesson.number, periods: periods))
            }
            
            rozkladModel.append(RozkladSwiftDataModel(date: rozklad.date, lessons: rozkladLessons))
        }
        
        context.insert(MainRozkladSwiftDataModel(rozklad: rozkladModel))
        try? context.save()
    }
    
    func fetchRozklad(context: ModelContext) -> [RozkladModel] {
        var rozModels = [RozkladModel]()
        
        let fetchDescriptor = FetchDescriptor<MainRozkladSwiftDataModel>()
        
        do {
            let results = try context.fetch(fetchDescriptor)
            guard let result = results.first else { return [] }
            for rozklad in result.rozklad {
                
                var lesModels = [LessonModel]()
                
                for lesson in rozklad.lessons {
                    
                    var perModels = [PeriodModel]()
                    
                    for period in lesson.periods {
                        perModels.append(PeriodModel(r1: period.r1, rz14: period.rz14, rz15: period.rz15, disciplineID: period.disciplineID, educationDisciplineID: period.educationDisciplineID, disciplineFullName: period.disciplineFullName, disciplineShortName: period.disciplineShortName, classroom: period.classroom, timeStart: period.timeStart, timeEnd: period.timeEnd, teachersName: period.teachersName, teachersNameFull: period.teachersNameFull, type: period.type, typeStr: period.typeStr, dateUpdated: period.dateUpdated, nonstandardTime: period.nonstandardTime, groups: period.groups, extraText: period.extraText))
                    }
                    lesModels.append(LessonModel(number: lesson.number, periods: perModels))
                }
                rozModels.append(RozkladModel(date: rozklad.date, lessons: lesModels))
            }
        } catch {
            print("pizda")
        }
    
        return rozModels
    }
}
