//
//  Font+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

extension Font {
    enum GilroyFont {
        case regular, semibold, medium, light

        var value: String {
            switch self {
            case .regular:  return "Gilroy-Regular"
            case .semibold: return "Gilroy-Semibold"
            case .medium:   return "Gilroy-Medium"
            case .light:    return "Gilroy-Light"
            }
        }
    }
    
    static func gilroy(_ type: GilroyFont, size: CGFloat = 14) -> Font {
        return .custom(type.value, size: size)
    }
}
