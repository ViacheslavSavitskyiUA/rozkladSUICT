//
//  RozkladSwiftDataModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.12.2024.
//

import Foundation
import SwiftData

@Model
class MainRozkladSwiftDataModel {
    var id: UUID
    var rozklad: [RozkladSwiftDataModel]

    init(rozklad: [RozkladSwiftDataModel]) {
        self.id = UUID()
        self.rozklad = rozklad
    }
}

@Model
class RozkladSwiftDataModel {
    var id: UUID
    var date: String
    var lessons: [LessonSwiftDataModel]
    
    init(date: String, lessons: [LessonSwiftDataModel]) {
        self.id = UUID()
        self.date = date
        self.lessons = lessons
    }
}

@Model
class LessonSwiftDataModel {
    var id: UUID
    var number: Int
    var periods: [PeriodSwiftDataModel]
    
    init(number: Int, periods: [PeriodSwiftDataModel]) {
        self.id = UUID()
        self.number = number
        self.periods = periods
    }
}

@Model
class PeriodSwiftDataModel {
    var id: UUID
    var r1: Int
    var rz14: Int
    var rz15: Int
    var disciplineID: Int
    var educationDisciplineID: Int
    var disciplineFullName: String
    var disciplineShortName: String
    var classroom: String
    var timeStart: String
    var timeEnd: String
    var teachersName: String
    var teachersNameFull: String
    var type: Int
    var typeStr: String
    var dateUpdated: String
    var nonstandardTime: Bool
    var groups: String
    var extraText: Bool
    
    init(r1: Int, rz14: Int, rz15: Int, disciplineID: Int, educationDisciplineID: Int, disciplineFullName: String, disciplineShortName: String, classroom: String, timeStart: String, timeEnd: String, teachersName: String, teachersNameFull: String, type: Int, typeStr: String, dateUpdated: String, nonstandardTime: Bool, groups: String, extraText: Bool) {
        self.id = UUID()
        self.r1 = r1
        self.rz14 = rz14
        self.rz15 = rz15
        self.disciplineID = disciplineID
        self.educationDisciplineID = educationDisciplineID
        self.disciplineFullName = disciplineFullName
        self.disciplineShortName = disciplineShortName
        self.classroom = classroom
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.teachersName = teachersName
        self.teachersNameFull = teachersNameFull
        self.type = type
        self.typeStr = typeStr
        self.dateUpdated = dateUpdated
        self.nonstandardTime = nonstandardTime
        self.groups = groups
        self.extraText = extraText
    }
}
