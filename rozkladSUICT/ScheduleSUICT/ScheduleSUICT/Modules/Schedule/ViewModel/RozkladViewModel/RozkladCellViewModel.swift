//
//  RozkladListViewModel.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 07.10.2023.
//

import Combine
import SwiftUI

enum RozkladStyle: String {
    case pz = "Пз",
         lk = "Лк",
         lb = "Лб",
         sem = "Сем",
         zach = "Зач",
         ekz = "Екз",
         dop = "Доп",
         zal = "Зал",
         dod = "Дод"
    
    
    var backgroundColor: Color {
        switch self {
        case .pz:   return .pz
        case .lk:   return .lk
        case .lb:   return .lb
        case .sem:  return .sem
        case .zach: return .zach
        case .ekz:  return .ekz
        case .dop:  return .dop
        case .zal:  return .zach
        case .dod:  return .dop
        }
    }
}

final class RozkladCellViewModel: ObservableObject {
    
    @Published var lesson: LessonEntity
    let type: UserType
    
    init(lesson: LessonEntity, type: UserType) {
        self.lesson = lesson
        self.type = type
    }
    
    func setupBackground() -> Color {
        print("typeSts \(lesson.typeStr) type \(lesson.type)")
        return RozkladStyle(rawValue: lesson.typeStr)?.backgroundColor ?? .pastelBianca
    }
}
