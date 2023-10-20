//
//  UserType.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation
import SwiftUI

enum UserType: String {
    case student, teacher, unowned, auditory, freeAuditory
    
    var title: String {
        switch self {
        case .student:      return "СТУДЕНТ/СТУДЕНТКА"
        case .teacher:      return "ВИКЛАДАЧ/ВИКЛАДАЧКА"
        case .auditory:     return "АУДИТОРІЯ"
        case .freeAuditory: return "ВІЛЬНІ АУДИТОРІЇ"
        default:            return ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .student:      return .pastelBianca
        case .teacher:      return .pastelFirstSnow
        case .auditory:     return .pastelFirstSnow
        case .freeAuditory: return .pastelBianca
        default:            return .clear
        }
    }
    
    var lottieFile: LottieFile {
        switch self {
        case .student:      return .student
        case .teacher:      return .teacher
        case .auditory:     return .auditory
        case .freeAuditory: return .freeAuditory
        default:            return .student
        }
    }
    
    var borderColor: Color {
        switch self {
        case .student:      return .fennelFlower
        case .teacher:      return .fallGold
        case .auditory:     return .fallGold
        case .freeAuditory: return .fennelFlower
        default:            return .clear
        }
    }
    
    var titleSelectItemsView: String {
        switch self {
        case .student:      return "Оберіть групу"
        case .teacher:      return "Знайдіть себе"
        case .auditory:     return "Оберіть аудиторію"
        case .freeAuditory: return "Вільні аудиторії"
        case .unowned:      return ""
        }
    }
}
