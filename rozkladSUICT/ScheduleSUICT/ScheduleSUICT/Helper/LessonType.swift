//
//  LessonType.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.10.2023.
//

import Foundation

enum LessonType: Int {
    case para1 = 1
    case para2 = 2
    case para3 = 3
    case para4 = 4
    case para5 = 5
    case para6 = 6
    case para7 = 7
    case para8 = 8
    
    //нотификация за 5 мин до начала пары
    var timeNotification: (hour: Int, minute: Int) {
        switch self {
        case .para1:
            return (hour: 7, minute: 55)
        case .para2:
            return (hour: 9, minute: 40)
        case .para3:
            return (hour: 11, minute: 40)
        case .para4:
            return (hour: 13, minute: 25)
        case .para5:
            return (hour: 15, minute: 10)
        case .para6:
            return (hour: 16, minute: 55)
        case .para7:
            return (hour: 18, minute: 40)
        case .para8:
            return (hour: 20, minute: 25)
        }
    }
}
