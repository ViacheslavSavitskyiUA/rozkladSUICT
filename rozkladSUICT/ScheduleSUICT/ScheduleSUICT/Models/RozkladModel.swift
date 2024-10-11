//
//  RozkladModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Foundation

struct RozkladModel: Codable {
    let date: String
    let lessons: [LessonModel]
}

// MARK: - Lesson
struct LessonModel: Codable {
    let number: Int
    let periods: [PeriodModel]
}

// MARK: - Period
struct PeriodModel: Codable {
    let r1, rz14, rz15: Int
    let disciplineID, educationDisciplineID: Int
    let disciplineFullName, disciplineShortName, classroom, timeStart: String
    let timeEnd, teachersName, teachersNameFull: String
    let type: Int
    let typeStr: String
    let dateUpdated: String
    let nonstandardTime: Bool
    let groups: String
    let extraText: Bool

    enum CodingKeys: String, CodingKey {
        case r1, rz14, rz15
        case disciplineID = "disciplineId"
        case educationDisciplineID = "educationDisciplineId"
        case disciplineFullName, disciplineShortName, classroom, timeStart, timeEnd, teachersName, teachersNameFull, type, dateUpdated, nonstandardTime, groups, extraText
        case typeStr
    }
}
