//
//  AuditoryEntity.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 20.10.2023.
//

import Foundation

class AuditoryEntity: BaseEntity, Equatable {
    static func == (lhs: AuditoryEntity, rhs: AuditoryEntity) -> Bool {
        lhs.number == rhs.number && lhs.id == rhs.id
    }
    
    let id: String
    let number: String
    
    init(id: String, number: String) {
        self.id = id
        self.number = number
    }
}
