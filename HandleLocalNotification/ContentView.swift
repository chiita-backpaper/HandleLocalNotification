//
//  ContentView.swift
//  HandleLocalNotification
//
//  Created by Taichi Uragami on 2022/01/19.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var toShowAlert: Bool = false
    let notificationName = "Pochi"
    let pub: NotificationCenter.Publisher
    let trigger: UNTimeIntervalNotificationTrigger
    
    
    init() {
        var dateComponents = DateComponents()
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        pub = NotificationCenter.default.publisher(for: Notification.Name(notificationName))
    }
    
    var body: some View {
        VStack {
            Button(action: {
                NotificationHandler.shared.addNotification(
                    id: notificationName,
                    title:"Your Notification" ,subtitle: "Have a nice day!", trigger: trigger)
            }, label : {
                Text("Send Notification")
            })
        }
        .onAppear{
            NotificationHandler.shared.requestPermission( onDeny: {
                self.toShowAlert.toggle()
            })
        }
        .alert(isPresented : $toShowAlert){
            
            Alert(title: Text("Notification has been disabled for this app"),
                  message: Text("Please go to settings to enable it now"),
                  primaryButton: .default(Text("Go To Settings")) {
                self.goToSettings()
            },
                  secondaryButton: .cancel())
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                UIApplication.shared.applicationIconBadgeNumber = 0
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
    }
}

extension ContentView {
    private func goToSettings(){
        // must execute in main thread
        DispatchQueue.main.async {
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:],
                                      completionHandler: nil)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
