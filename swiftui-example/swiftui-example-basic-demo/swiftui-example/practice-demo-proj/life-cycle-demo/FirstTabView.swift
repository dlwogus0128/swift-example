//
//  FirstTabView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct FirstTabView: View {
    
    @State var title = "View One"
    
    var body: some View {
        Text("Title")
            .onAppear(perform: {
                print("onAppear triggered")
            })
            .onDisappear(perform: {
                print("onDisappeared triggered")    // second view item을 누를 때 사라지면서 실행됨
            })
            .task(priority: .background, {
                title = await changeTitle()
            })
    }
    
    func changeTitle() async -> String {
        sleep(5)
        return "Async task complete"
    }
}
