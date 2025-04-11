//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by Danilo Osorio on 10/04/25.
//

import SwiftUI
import Firebase
import FirebaseAnalytics


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SaveLinkApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView().onAppear {
            Analytics.logEvent("ContentView_loaded", parameters: [
                "screen_name": "ContentView"
            ])
        }
      }
    }
  }
}
