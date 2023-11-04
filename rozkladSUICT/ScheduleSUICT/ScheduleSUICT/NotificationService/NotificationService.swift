//
//  NotificationService.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.10.2023.
//

import Foundation
import UserNotifications
import UIKit

class NotificationService {

    static func scheduleNotifications(models: [RozkladEntity], userType: UserType) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { isSuccess, error in
            if isSuccess {
                   print("User Accepted")
                
                for model in models {
                    for (index, lesson) in model.lessons.enumerated() {
                        setupNotification(date: model.date, lesson: lesson)
        //                mock(date: model.date, lesson: lesson, index: index)
                    }
                }
               } else if let error = error {
                   print(error.localizedDescription)
              }
        }
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for model in models {
            for (index, lesson) in model.lessons.enumerated() {
                setupNotification(date: model.date, lesson: lesson)
//                mock(date: model.date, lesson: lesson, index: index)
            }
        }
        
        func setupNotification(date: String, lesson: LessonEntity) {
            let content = UNMutableNotificationContent()
            var dateComponents = DateComponents()
            
            content.title = "Через 5 хвилин початок пари"
            content.body = "\(lesson.disciplineShortName), \(lesson.classroom) ауд., \(userType == .student ? lesson.teachersName : lesson.groups)"
            content.badge = 1
            content.sound = .default
            
            dateComponents.year = Int(date.substring(from: 0, length: 4))
            dateComponents.month = Int(date.substring(from: 5, length: 2))
            dateComponents.day = Int(date.substring(from: 8, length: 2))

            dateComponents.hour = Int(LessonType(rawValue: lesson.lessonNumber)?.timeNotification.hour ?? 0)
            dateComponents.minute = Int(LessonType(rawValue: lesson.lessonNumber)?.timeNotification.minute ?? 0)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                        repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
        
        func mock(date: String, lesson: LessonEntity, index: Int) {
            let content = UNMutableNotificationContent()
            var dateComponents = DateComponents()
            
            content.title = "Через 5 хвилин початок пари"
    //        content.body = "\(lesson.disciplineShortName), \(lesson.classroom) ауд., \(userType == .student ? lesson.teachersName : lesson.groups)"
            content.body = "\(lesson.disciplineShortName)"
            content.badge = 1
            content.sound = .default
            
            dateComponents.year = 2023
            dateComponents.month = 10
            dateComponents.day = 30

            dateComponents.hour = 15
            dateComponents.minute = 49 + index//Int(LessonType(rawValue: lesson.lessonNumber)?.timeNotification.minute ?? 0)
            dateComponents.second = 0 + index
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                        repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
    }
}
