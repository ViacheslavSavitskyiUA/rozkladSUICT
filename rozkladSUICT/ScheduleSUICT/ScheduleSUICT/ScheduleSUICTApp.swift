//
//  ScheduleSUICTApp.swift
//  ScheduleSUICT
//
//  Created by Viacheslav Savitskyi on 28.09.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      Analytics.setAnalyticsCollectionEnabled(true)
      Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)

//      let x: String? = nil
//      let y: String = x!
      
    return true
  }
}

@main
struct ScheduleSUICTApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: .init())
                .modelContainer(for: [MainRozkladSwiftDataModel.self])
        }
    }
}
