//
//  ChoiceEntity.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 30.09.2023.
//

import Foundation

class ChoiceEntity: BaseEntity {
    let id: Int
    let shortName: String?
    let fullName: String
    let initials: String?
    
    init(id: Int, shortName: String?, fullName: String, initials: String?) {
        self.id = id
        self.shortName = shortName
        self.fullName = fullName
        self.initials = initials
    }
}
