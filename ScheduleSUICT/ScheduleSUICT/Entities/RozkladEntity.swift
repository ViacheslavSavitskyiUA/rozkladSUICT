//
//  RozkladEntity.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Foundation

struct RozkladEntity: Identifiable {
    var id = UUID()
    
    var date: String
    var lessons: [LessonEntity]
}

struct LessonEntity: Identifiable {
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
    init(date: String = "", lessons: [LessonEntity] = []) {
        self.date = date
        self.lessons = lessons
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
