//
//  Date+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Foundation

extension Date {
    func inRange(from: Date, to: Date, checkDate: Date) -> Bool {
        let range = from...to
        return range.contains(checkDate)
    }
    
    func adding(seconds: Int, to: Date) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: to) ?? .init()
    }
    
    func getCurrentWeekDays() -> [Date] {
        let dateComponents = Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        let startOfWeek = Calendar(identifier: .iso8601).date(from: dateComponents)!
        let startOfWeekNoon = Calendar(identifier: .iso8601).date(bySettingHour: 12, minute: 0, second: 0, of: startOfWeek)!
        let weekDays = (0...90).map { Calendar(identifier: .iso8601).date(byAdding: .day, value: $0, to: startOfWeekNoon)! }
        return weekDays
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
}
