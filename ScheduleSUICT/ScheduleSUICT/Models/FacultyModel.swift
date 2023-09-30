//
//  FacultyModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Foundation

// MARK: - FacultyModel
class FacultyModel: BaseModel, Codable {
    let id: Int
    let shortName, fullName: String
}
