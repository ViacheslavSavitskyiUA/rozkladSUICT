//
//  RozkladEntity.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Foundation
import SwiftUI

struct RozkladEntity: Identifiable, Hashable, Equatable {
    
    static func == (lhs: RozkladEntity, rhs: RozkladEntity) -> Bool {
        lhs.id == rhs.id && lhs.date == rhs.date && lhs.dayWeek == rhs.dayWeek && lhs.isToday == rhs.isToday && lhs.isSelected == rhs.isSelected && lhs.lessons == rhs.lessons && lhs.isEmpty == rhs.isEmpty
    }
    
    var id = UUID()
    
    var date: String
    var dayWeek: String
    
    var isToday: Bool
    var isSelected: Bool
    
    var lessons: [LessonEntity]
    
    var isEmpty: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(dayWeek)
        hasher.combine(isToday)
        hasher.combine(isSelected)
        hasher.combine(lessons)
        hasher.combine(isEmpty)
    }
}

struct LessonEntity: Identifiable, Hashable, Equatable {
    var id = UUID()
    
    var lessonNumber: Int
    
    var disciplineFullName: String
    var disciplineShortName: String
    
    var classroom: String

    var timeStart: String
    var timeEnd: String
    
    var teachersName: String
    var teachersNameFull: String
    
    var groups: String
    
    var type: Int
    var typeStr: String
    
    init(id: UUID = UUID(), lessonNumber: Int, disciplineFullName: String, disciplineShortName: String, classroom: String, timeStart: String, timeEnd: String, teachersName: String, teachersNameFull: String, groups: String, type: Int, typeStr: String) {
        self.id = id
        self.lessonNumber = lessonNumber
        self.disciplineFullName = disciplineFullName
        self.disciplineShortName = disciplineShortName
        self.classroom = classroom
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.teachersName = teachersName
        self.teachersNameFull = teachersNameFull
        self.groups = groups
        self.type = type
        self.typeStr = typeStr
    }
    
    
}

// MARK: -  RozkladEntity empty init
extension RozkladEntity {
    init(date: String = "", dayWeek: String = "", lessons: [LessonEntity] = [], isToday: Bool = false, isSelected: Bool = false) {
        self.date = date
        self.dayWeek = dayWeek
        self.lessons = lessons
        self.isToday = isToday
        self.isSelected = isSelected
    }
}

// MARK: -  LessonEntity empty init
extension LessonEntity {
    init(lessonNumber: Int = 0, disciplineFullName: String = "", disciplineShortName: String = "", classroom: String = "", timeStart: String = "", timeEnd: String = "", teachersName: String = "", teachersNameFull: String = "", groups: String = "", type: Int = 0, typeStr: String = "") {
        self.lessonNumber = lessonNumber
        self.disciplineFullName = disciplineFullName
        self.disciplineShortName = disciplineShortName
        self.classroom = classroom
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.teachersName = teachersName
        self.teachersNameFull = teachersNameFull
        self.groups = groups
        self.type = type
        self.typeStr = typeStr
    }
}
