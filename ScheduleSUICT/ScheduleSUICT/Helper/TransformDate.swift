//
//  TransformDate.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 05.10.2023.
//

import Foundation

enum DateFormat {
    case eeee // Monday
    case ddMMyyyy // 01.12.2022
    case yyyyMMdd
    case iso
    case HHdd
    case MMddyyyyHHmm
    
    var description: String {
        switch self {
        case .eeee:
            return "EEEE"
        case .ddMMyyyy:
            return "dd.MM.yyyy"
        case .yyyyMMdd:
            return "yyyy-MM-dd"
        case .iso:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .HHdd:
            return "HH:dd"
        case .MMddyyyyHHmm:
            return "MM-dd-yyyy HH:mm"
        }
    }
}

struct Transform {
    static func transformDateToString(date: Date, dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.description
        dateFormatter.locale = Locale(identifier: "uk_UA")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func transformStringToDate(_ dateString: String, dateFormat: DateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.description
        let date = (dateFormatter.date(from: dateString) ?? .init())
        return date
    }
    
    static func remove(from date: Date, seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: -seconds, to: date) ?? .now
    }
}
