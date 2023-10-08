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
}
