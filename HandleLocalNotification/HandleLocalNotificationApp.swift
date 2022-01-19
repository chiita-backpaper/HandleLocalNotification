//
//  HandleLocalNotificationApp.swift
//  HandleLocalNotification
//
//  Created by Taichi Uragami on 2022/01/19.
//

import SwiftUI

@main
struct HandleLocalNotificationApp: App {
    init() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.set(0, forKey: "NotificationBadgeCount")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
