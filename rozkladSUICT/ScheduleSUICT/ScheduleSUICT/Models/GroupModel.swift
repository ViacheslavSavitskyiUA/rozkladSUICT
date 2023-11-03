//
//  GroupModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 01.10.2023.
//

import Foundation

// MARK: - GroupModel
struct GroupModel: Codable {
    let id: Int
    let name: String
    let course, priority, educationForm: Int
}
