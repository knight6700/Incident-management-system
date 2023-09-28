//
//  IncidentManagementSystemApp.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI
import netfox

@main
struct IncidentManagementSystemApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            IncidentListView()
                .preferredColorScheme(.light)

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        startNetworkLogger()
        return true
    }
}

extension AppDelegate {
    func startNetworkLogger() {
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
    }
}
