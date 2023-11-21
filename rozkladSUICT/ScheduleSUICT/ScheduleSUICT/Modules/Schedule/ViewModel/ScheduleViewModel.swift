//
//  ScheduleViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 04.10.2023.
//

import Combine
import Foundation
import SwiftUI

enum UserDataStatus {
    case saved, unsaved
}

final class ScheduleViewModel: ObservableObject {
    
    @Published var isShowLoader = false
    private var isShowErrorView = false
    
    @Published var navigationTitle: String
    
    @Published var isShowSaveAlert: Bool = false
    
    @Published var userDataStatus: UserDataStatus = .unsaved
    
    @Published var saveImageFlag: Bool = false
    
    let network = NetworkManager()
    @Published var rozklad: [RozkladEntity] = []
    private var days: [DayEntity] = []
    
    private let searchId: Int
    let type: UserType
    
    var notificationService: NotificationService
    
    init(searchId: Int, type: UserType, title: String) {
        self.searchId = searchId
        self.type = type
        self.navigationTitle = title
        
        if type == .auditory {
            self.navigationTitle = "\(title) аудиторія"
        }
        
        notificationService = NotificationService()
        
        notificationService.scheduleNotifications(models: rozklad,
                                                  userType: type)
    }
    
    func saveUserData() {
        notificationService.scheduleNotifications(models: rozklad,
                                                  userType: type)
        
        StorageService.storageId(searchId)
        StorageService.storageType(type.rawValue)
        StorageService.storageTitle(navigationTitle)
        
        userDataStatus = .saved
        checkReturnSaveImage()
        
        Task {
            await checkPush()
        }
    }
    
    func unsaveUserData() {
        StorageService.storageId(nil)
        StorageService.storageType(nil)
        StorageService.storageTitle(nil)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        userDataStatus = .unsaved
        checkReturnSaveImage()
        
        Task {
            await checkPush()
        }
    }
    
    func checkReturnSaveImage() {
        saveImageFlag = userDataStatus == .saved ? true : false
    }
    
    func askedSaveQuestion() {
        if StorageService.readStorageTitle() != self.navigationTitle &&
            StorageService.readStorageId() != searchId &&
            StorageService.readStorageType() != type {
            withAnimation {
                isShowSaveAlert = true
            }
        }
    }
    
    @MainActor
    func transformRangeDateString() -> (start: String, end: String) {
        let dates = Date().getCurrentWeekDays()
        
        let start = Transform.transformDateToString(date: dates.first ?? .now, dateFormat: .yyyyMMdd)
        let end = Transform.transformDateToString(date: dates.last ?? .now, dateFormat: .yyyyMMdd)
        return (start: start, end: end)
    }
    
    @MainActor
    func transformRozklad(models: [RozkladModel]) async {
        var rozkladObject: RozkladEntity = .init()
        
        for model in models {
            rozkladObject.date = model.date
            for lesson in model.lessons {
                for period in lesson.periods {
                    rozkladObject.lessons.append(
                        .init(lessonNumber: lesson.number,
                              disciplineFullName: period.disciplineFullName,
                              disciplineShortName: period.disciplineShortName,
                              classroom: period.classroom,
                              timeStart: period.timeStart,
                              timeEnd: period.timeEnd,
                              teachersName: period.teachersName,
                              teachersNameFull: period.teachersNameFull,
                              groups: period.groups,
                              type: period.type,
                              typeStr: period.typeStr))
                }
            }
            rozklad.append(rozkladObject)
            rozkladObject = .init()
        }
    }
    
    @MainActor
    func checkPush() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let center = self.notificationService.notificationCenter
            center.getPendingNotificationRequests { (notifications) in
                print("Count: \(notifications.count)")
                for item in notifications {
                    print(item.trigger)
                }
            }
        })
    }
}

