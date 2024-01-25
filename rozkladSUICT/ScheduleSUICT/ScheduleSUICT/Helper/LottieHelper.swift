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
    case auditory = "auditoryAnimation"
    case freeAuditory = "freeAuditoryAnimation"
    
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
        case a14 = "animation14"
        case a15 = "animation15"
    }
    
    enum NetworkError: String {
        case animation = "animationNetrorkError"
    }
    
    enum SavePopUp: String {
        case checkmark = "checkmark"
        case crissCross = "criss-cross"
    }
    
    enum NewYear: String {
        case cat = "newYear_cat"
        case light = "newYear_lights"
        
        enum EmptyLessons: String, CaseIterable {
            case a3 =  "ny_animation3"
            case a6 =  "ny_animation6"
            case a7 =  "ny_animation7"
            case a8 =  "ny_animation8"
            case a9 =  "ny_animation9"
            case a10 = "ny_animation10"
            case a11 = "ny_animation11"
            case a13 = "ny_animation13"
            case a14 = "ny_animation14"
            case a15 = "ny_animation15"
        }
    }
}
