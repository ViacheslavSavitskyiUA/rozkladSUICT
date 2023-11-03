//
//  UserType.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation
import SwiftUI

enum UserType: String {
    case student, teacher, unowned, auditory
    
    var title: String {
        switch self {
        case .student:      return "СТУДЕНТ/СТУДЕНТКА"
        case .teacher:      return "ВИКЛАДАЧ/ВИКЛАДАЧКА"
        case .auditory:     return "АУДИТОРІЯ"
        default:            return ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .student:      return .pastelFirstSnow//pastelBianca
        case .teacher:      return .pastelFirstSnow
        case .auditory:     return .pastelFirstSnow
        default:            return .clear
        }
    }
    
    var lottieFile: LottieFile {
        switch self {
        case .student:      return .student
        case .teacher:      return .teacher
        case .auditory:     return .auditory
        default:            return .student
        }
    }
    
    var borderColor: Color {
        switch self {
        case .student:      return .fallGold//fennelFlower
        case .teacher:      return .fallGold
        case .auditory:     return .fallGold
        default:            return .clear
        }
    }
    
    var titleSelectItemsView: String {
        switch self {
        case .student:      return "Оберіть групу"
        case .teacher:      return "Знайдіть себе"
        case .auditory:     return "Оберіть аудиторію"
        case .unowned:      return ""
        }
    }
}
