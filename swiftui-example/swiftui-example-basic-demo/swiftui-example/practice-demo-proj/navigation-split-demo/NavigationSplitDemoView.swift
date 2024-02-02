//
//  NavigationSplitDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct NavigationSplitDemoView: View {
    @State private var colors = ["Red", "Green", "Blue"]
    @State private var selectedColor: String?
    @State private var columVisibility = NavigationSplitViewVisibility.detailOnly
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columVisibility) {
            List(colors, id: \.self, selection: $selectedColor) { color in
                Text(color).tag(color)
            }
        } detail: {
            Text( selectedColor ?? "No color selected")
        }
        .navigationSplitViewStyle(.automatic)
    }
}

#Preview {
    NavigationSplitDemoView()
}
