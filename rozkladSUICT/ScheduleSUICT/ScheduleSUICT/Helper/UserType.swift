//
//  UserType.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation
import SwiftUI

enum UserType: String {
    case student, teacher, unowned, auditory, hero
    
    var title: String {
        switch self {
        case .student:      return "СТУДЕНТ/СТУДЕНТКА"
        case .teacher:      return "ВИКЛАДАЧ/ВИКЛАДАЧКА"
        case .auditory:     return "АУДИТОРІЯ"
        case .hero:         return "НА ЩИТІ"
        default:            return ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .student:      return .pastelFirstSnow//pastelBianca
        case .teacher:      return .pastelFirstSnow
        case .auditory:     return .pastelFirstSnow
        case .hero:         return .black
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
        case .hero:         return .fallGold
        default:            return .clear
        }
    }
    
    var titleSelectItemsView: String {
        switch self {
        case .student:      return "Оберіть групу"
        case .teacher:      return "Знайдіть себе"
        case .auditory:     return "Оберіть аудиторію"
        case .hero:         return "На щиті!"
        case .unowned:      return ""
        }
    }
}
