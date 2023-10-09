//
//  DayCollectionViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Combine
import Foundation

final class DayCollectionViewModel: ObservableObject {
    
    @Published var days: [DayEntity] = []
    
    @MainActor
    func setupDaysInWeek() async {
        let dates = Date().getCurrentWeekDays()
        
        for date in dates {
            days.append(DayEntity(dayString: Transform.transformDateToString(date: date,
                                                                             dateFormat: .eeee).capitalized,
                                  dateString: Transform.transformDateToString(date: date,
                                                                              dateFormat: .ddMMyyyy),
                                  isToday: Calendar.current.isDateInToday(date),
                                  dateISOString: Transform.transformDateToString(date: date,
                                                                                 dateFormat: .iso),
                                  isSelected: Calendar.current.isDateInToday(date)))
        }
    }
    
    @MainActor
    func selected(day: DayEntity) {
        for (index, element) in days.enumerated() {
            days[index].isSelected = element.id == day.id ? true : false
        }
    }
    
    @MainActor
    func fetchDays() async {
        await setupDaysInWeek()
        
        print("days \(days)")
        let dayStartDate = Transform.transformStringToDate(days.first?.dateISOString ?? "",
                                                           dateFormat: .iso)
        let dayEndDate = Transform.transformStringToDate(days.last?.dateISOString ?? "",
                                                         dateFormat: .iso)
        
        print("dayStartDate \(dayStartDate)")
        print("dayEndDate \(dayEndDate)")
    }
}


