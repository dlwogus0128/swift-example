//
//  swiftui_exampleApp.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

@main
struct swiftui_exampleApp: App {
    @Environment(\.scenePhase) private var scenePhase   // 현재 화면의 상태를 저장하기 위한 속성
    
    var body: some Scene {
        WindowGroup {
            CarListDemoView()
        }
        // 화면 단계가 앱 내 모든 화면의 상태를 기반으로 함
        .onChange(of: scenePhase, perform: { phase in   // 이 부분이 활성화되는 경우는, 화면이 포->백그라운드로 전환되거나, 활성화->비활성화로 변경될 때 등의 경우에서
            switch phase {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
            case .background:
                print("Background")
            default:
                print("Unknown scenephase")
            }
        })
        DocumentGroup(newDocument: DocDemoDocumnet()) { file in
            DocDemoView(documnet: file.$document)
        }
}
