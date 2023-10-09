//
//  ScheduleSUICTApp.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI

@main
struct ScheduleSUICTApp: App {
    var body: some Scene {
        WindowGroup {
            ChoiceView(viewModel: .init())
//            ScheduleView(viewModel: .init(searchId: 569, type: .teacher))
        }
    }
}
