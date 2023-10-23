//
//  ChoiceViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 29.09.2023.
//

import Combine
import SwiftUI

final class ChoiceViewModel: ObservableObject {
    
    @Published var studentCardViewModel: ChoiceCardViewModel
    @Published var teacherCardViewModel: ChoiceCardViewModel
    @Published var auditoryCardViewModel: ChoiceCardViewModel
    
    @Published var selectUserType: UserType = .unowned
    
    @Published var isToNextScreen = false
    @Published var isToNextScreenAuditory = false
    @Published var isToNextScreenFreeAuditory = false
    
    @Published var isToNextMain = false {
        didSet {
            if selectUserType == .student || selectUserType == .teacher {
                isToNextScreen = true
                isToNextScreenAuditory = false
            } else if selectUserType == .auditory {
                isToNextScreen = false
                isToNextScreenAuditory = true
                isToNextScreenFreeAuditory = false
            } else {
                isToNextScreen = false
                isToNextScreenAuditory = false
                isToNextScreenFreeAuditory = false
            }
        }
    }
    
    @Published var isToScheduleScreen = false
    
    init() {
        self.studentCardViewModel = ChoiceCardViewModel()
        self.teacherCardViewModel = ChoiceCardViewModel()
        self.auditoryCardViewModel = ChoiceCardViewModel()
    }
    
    func showSchedule() {
        if StorageService.readStorageId() != nil && StorageService.readStorageType() != nil && StorageService.readStorageTitle() != nil {
            isToScheduleScreen = true
        }
    }
    
    func select(userType: UserType) {
        withAnimation(.easeInOut) {

            self.selectUserType = userType
            
            switch userType {
            case .student:
                studentCardViewModel.isSelect = true
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = false
            case .teacher:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = true
                auditoryCardViewModel.isSelect = false
            case .unowned: ()
            case .auditory:
                studentCardViewModel.isSelect = false
                teacherCardViewModel.isSelect = false
                auditoryCardViewModel.isSelect = true
            }
        }
    }
}
