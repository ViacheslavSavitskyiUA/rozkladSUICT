//
//  LottieHelper.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import Foundation

enum LottieFile {
    case student
    case teacher
    case loader
    
    var fileName: String {
        switch self {
        case .student: return "studentAnimation"
        case .teacher: return "teacherAnimation"
        case .loader:  return "loaderAnimation"
        }
    }
}
