//
//  StorageService.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 17.10.2023.
//

import Foundation

enum SettingsKey: String {
    case id
    case type
    case title
    case firstLunch
}

class StorageService {
    static func storageId(_ id: Int?) {
        UserDefaults.standard.set(id, forKey: SettingsKey.id.rawValue)
    }
    
    static func readStorageId() -> Int? {
         UserDefaults.standard.integer(forKey: SettingsKey.id.rawValue)
    }
    
    static func storageType(_ type: String?) {
        UserDefaults.standard.set(type, forKey: SettingsKey.type.rawValue)
    }
    
    static func readStorageType() -> UserType? {
         UserType(rawValue: UserDefaults.standard.string(forKey: SettingsKey.type.rawValue) ?? "")
    }
    
    static func storageTitle(_ title: String?) {
        UserDefaults.standard.set(title, forKey: SettingsKey.title.rawValue)
    }
    
    static func readStorageTitle() -> String? {
         UserDefaults.standard.string(forKey: SettingsKey.title.rawValue)
    }
    
    static func firstLounch(_ isFirst: Bool?) {
        UserDefaults.standard.set(isFirst, forKey: SettingsKey.firstLunch.rawValue)
    }
    
    static func readIsFirstLounch() -> Bool? {
        UserDefaults.standard.bool(forKey: SettingsKey.firstLunch.rawValue)
    }
}
