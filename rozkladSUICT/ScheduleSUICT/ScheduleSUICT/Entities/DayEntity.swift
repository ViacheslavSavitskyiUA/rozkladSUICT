//
//  DayEntity.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 06.10.2023.
//

import Foundation

struct DayEntity: Identifiable {
    var id = UUID()
    var dayString: String
    var dateString: String
    var isToday: Bool
    var dateISOString: String
    var isSelected: Bool
}
