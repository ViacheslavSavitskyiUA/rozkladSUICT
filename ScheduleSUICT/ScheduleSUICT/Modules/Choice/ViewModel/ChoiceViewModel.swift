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
    
    @Published var selectUserType: UserType = .unowned
    
    @Published var isToNextScreen = false
    
    
    init() {
        self.studentCardViewModel = ChoiceCardViewModel()
        self.teacherCardViewModel = ChoiceCardViewModel()
    }
    
    func select(userType: UserType) {
        withAnimation(.easeInOut) {
        studentCardViewModel.isSelect = userType == .student ? true : false
        teacherCardViewModel.isSelect = userType == .teacher ? true : false

        selectUserType = userType
        }
    }
}
