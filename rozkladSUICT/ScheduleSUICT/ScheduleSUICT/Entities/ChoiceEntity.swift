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
    let cafedraFull: String?
    let cafedraShort: String?
    
    init(id: Int,
         shortName: String?,
         fullName: String,
         initials: String?,
         cafedraFull: String? = nil,
         cafedraShort: String? = nil) {
        self.id = id
        self.shortName = shortName
        self.fullName = fullName
        self.initials = initials
        self.cafedraFull = cafedraFull
        self.cafedraShort = cafedraShort
    }
}
