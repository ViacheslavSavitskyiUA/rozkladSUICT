//
//  UserType.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation
import SwiftUI

enum UserType: String {
    case student, teacher, unowned
    
    var title: String {
        switch self {
        case .student: return "СТУДЕНТ/СТУДЕНТКА"
        case .teacher: return "ВИКЛАДАЧ/ВИКЛАДАЧКА"
        default:       return ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .student: return .pastelBianca
        case .teacher: return .pastelFirstSnow
        default:       return .clear
        }
    }
    
    var lottieFile: LottieFile {
        switch self {
        case .student: return .student
        case .teacher: return .teacher
        default:       return .student
        }
    }
    
    var borderColor: Color {
        switch self {
        case .student: return .fennelFlower
        case .teacher: return .fallGold
        default:       return .clear
        }
    }
    
    var titleSelectItemsView: String {
        switch self {
        case .student: return "Оберіть групу"
        case .teacher: return "Знайдіть себе"
        case .unowned: return ""
        }
    }
}
