//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by Danilo Osorio on 10/04/25.
//

import SwiftUI
import Firebase
import FirebaseAnalytics
import FacebookLogin

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions)
    FirebaseApp.configure()
    return true
  }
}

@main
struct SaveLinkApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State var authenticationViewModel = AuthenticationViewModel()
    @StateObject var remoteConfig = RemoteConfiguration()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        if let _ = authenticationViewModel.user {
            HomeView(authenticationViewModel: authenticationViewModel)
                .environmentObject(remoteConfig)
        } else {
          AuthenticationView(authenticationViewModel: authenticationViewModel)
        }
      }
      .onAppear {
        Analytics.logEvent("ContentView_loaded", parameters: [
          "screen_name": "ContentView"
        ])
      }
    }
  }
}
