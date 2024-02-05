//
//  ShortcutDemoApp.swift
//  ShortcutDemo
//
//  Created by Neil Smyth on 7/29/22.
//

import SwiftUI
import Intents

@main
struct ShortcutDemoApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            INPreferences.requestSiriAuthorization({ status in
                // 상태에 대한 처리
            })
        }
    }
}
