//
//  DayCellViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import SwiftUI

final class DayCellViewModel: ObservableObject {
    
    @Published var day: RozkladEntity
    
    init(day: RozkladEntity) {
        self.day = day
    }
    
    func transformDate() -> String {
        Transform.transformDateToString(date: Transform.transformStringToDate(day.date, dateFormat: .yyyyMMdd), dateFormat: .ddMMyyyy)
    }
    
    func foregroundColor() -> Color {
        var color = Color.clear
        
        if day.isSelected {
            if day.isToday {
                color = .fallGold.opacity(0.7)
            } else {
                color = .pastelBianca
            }
        } else {
            if day.isToday {
                color = .fennelFlower.opacity(0.7)
            } else {
                color = .pastelFirstSnow
            }
        }
        
        return color
    }
}
