//
//  DayCollectionViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Combine
import Foundation

final class DayCollectionViewModel: ObservableObject {
    
    @Published var days: [RozkladEntity] = []
    
    @MainActor
    func selected(day: RozkladEntity) {
        for (index, element) in days.enumerated() {
            days[index].isSelected = element.date == day.date ? true : false
        }
    }
    
//    @MainActor
//    func fetchDays() async {
//        await setupDaysInWeek()
//        
//        print("days \(days)")
//        let dayStartDate = Transform.transformStringToDate(days.first?.dateISOString ?? "",
//                                                           dateFormat: .iso)
//        let dayEndDate = Transform.transformStringToDate(days.last?.dateISOString ?? "",
//                                                         dateFormat: .iso)
//        
//        print("dayStartDate \(dayStartDate)")
//        print("dayEndDate \(dayEndDate)")
//    }
}


