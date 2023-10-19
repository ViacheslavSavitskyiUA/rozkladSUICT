//
//  LottieHelper.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation

enum LottieFile: String {
    case student = "studentAnimation"
    case teacher = "teacherAnimation"
    case loader = "loaderAnimation"
    
    enum EmptyLessons: String, CaseIterable {
        case a1 = "animation1"
        case a2 = "animation2"
        case a6 = "animation6"
        case a8 = "animation8"
        case a9 = "animation9"
        case a10 = "animation10"
        case a11 = "animation11"
        case a12 = "animation12"
        case a13 = "animation13"
    }
    
    enum NetworkError: String {
        case animation = "animationNetrorkError"
    }
    
    enum SavePopUp: String {
        case checkmark = "checkmark"
        case crissCross = "criss-cross"
    }
}
