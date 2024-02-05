//
//  swiftui_example_coredata_demoApp.swift
//  swiftui-example-coredata-demo
//
//  Created by 픽셀로 on 2/2/24.
//

import SwiftUI
import Intents

// 영구 컨트롤러를 만들었으므로
// 이를 사용하여 뷰 콘텍스트에 대한 참조를 얻을 수 있음

@main
struct swiftui_example_coredata_demoApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            INPreferences.requestSiriAuthorization({ status in
                
            })
        }
    }
}
