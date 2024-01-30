//
//  GridDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct GridDemoView: View {
    private var colors: [Color] = [.blue, .yellow, .green]
//    private var gridItems = [GridItem(.flexible()),
//                             GridItem(.flexible()),
//                             GridItem(.flexible())]
//    
//    private var gridItems = [GridItem(.adaptive(minimum: 100))]
    private var gridItems = [GridItem(.fixed(100)), GridItem(.fixed(200)), GridItem(.fixed(300))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 5) {
                ForEach((0...99), id: \.self) { index in
                    CellContent(index: index, color: colors[index % colors.count])
                }
            }
            .padding(5)
        }
    }
}

struct CellContent: View {
    var index: Int
    var color: Color
    
    var body: some View {
        Text("\(index)")
            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 100)
            .background(color)
            .cornerRadius(8)
            .font(.system(.largeTitle))
    }
}

#Preview {
    GridDemoView()
}
