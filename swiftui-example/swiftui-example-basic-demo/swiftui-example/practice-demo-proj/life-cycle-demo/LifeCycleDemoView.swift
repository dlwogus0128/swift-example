//
//  LifeCycleDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct LifeCycleDemoView: View {
    var body: some View {
        TabView {
            FirstTabView()
                .tabItem {
                    Image(systemName: "01.circle")
                    Text("First")
                }
            SecondTabView()
                .tabItem {
                    Image(systemName: "02.circle")
                    Text("Second")
                }
        }
    }
}

#Preview {
    LifeCycleDemoView()
}
