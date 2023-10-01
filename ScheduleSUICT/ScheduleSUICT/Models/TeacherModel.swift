//
//  TeacherModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 01.10.2023.
//

import Foundation

// MARK: - TeacherModel
struct TeacherModel: Codable {
    let id: Int
    let firstName, secondName, lastName: String
}
