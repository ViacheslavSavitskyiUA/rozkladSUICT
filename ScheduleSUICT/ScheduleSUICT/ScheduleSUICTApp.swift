//
//  ScheduleSUICTApp.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

@main
struct ScheduleSUICTApp: App {

    init() {
        UIApplication.shared.applicationIconBadgeNumber = 1
    }
    
    var body: some Scene {
        WindowGroup {
            ChoiceView(viewModel: .init())
//            SelectAuditoryListView(viewModel: .init())
        }
    }
}
