//
//  ContentView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("GoodBye, World!")
            Text("Hello, ") + Text("how ") + Text("are you")
        }
    }
}

#Preview {
    ContentView()
}
