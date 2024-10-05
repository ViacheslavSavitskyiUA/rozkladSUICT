//
//  UserDefaults+Extension.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 03.10.2024.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
