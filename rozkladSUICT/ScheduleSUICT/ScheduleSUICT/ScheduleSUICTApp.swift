//
//  ScheduleSUICTApp.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ScheduleSUICTApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    var body: some Scene {
        WindowGroup {
//            OnboardingView()
            SplashView(viewModel: .init())
            
            
//            SelectAuditoryListView(viewModel: .init())
        }
    }
}
