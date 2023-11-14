//
//  NotificationService.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.10.2023.
//

import Foundation
import UserNotifications
import UIKit

class NotificationService: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func scheduleNotifications(models: [RozkladEntity], userType: UserType) {
        
        var registeredNotifications = 0
        let limit = 64
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { isSuccess, error in
            if isSuccess {
                print("User Accepted")
                
                self.notificationCenter.removeAllPendingNotificationRequests()
                
                for model in models {
                    for lesson in model.lessons {
                        registeredNotifications < limit 
                        ? setupNotification(date: model.date, lesson: lesson)
                        : print("sorry limit")
                    }
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        notificationCenter.removeAllPendingNotificationRequests()
        
        for model in models {
            for lesson in model.lessons {
                if registeredNotifications < limit {
                    print(registeredNotifications)
                    setupNotification(date: model.date, lesson: lesson)
                }
            }
        }
        
        func setupNotification(date: String, lesson: LessonEntity) {
            let content = UNMutableNotificationContent()
            var dateComponents = DateComponents()
            
            content.title = "Через 5 хвилин початок пари"
            content.body  = "\(lesson.disciplineShortName), \(lesson.classroom) ауд., \(userType == .student ? lesson.teachersName : lesson.groups)"
            content.badge = 1
            content.sound = .default
            
            dateComponents.year  = Int(date.substring(from: 0, length: 4))
            dateComponents.month = Int(date.substring(from: 5, length: 2))
            dateComponents.day   = Int(date.substring(from: 8, length: 2))
            
            dateComponents.hour   = Int(LessonType(rawValue: lesson.lessonNumber)?.timeNotification.hour ?? 0)
            dateComponents.minute = Int(LessonType(rawValue: lesson.lessonNumber)?.timeNotification.minute ?? 0)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                        repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)
            notificationCenter.add(request)
            registeredNotifications += 1
        }
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
