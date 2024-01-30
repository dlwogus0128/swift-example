//
//  GridDemoRowView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct GridDemoRowView: View {
    var body: some View {
        Grid(horizontalSpacing: 30, verticalSpacing: 0) {
            GridRow {
                ForEach(1...5, id: \.self) { index in
                    if (index % 2 == 1) {
                        GridDemoRowCellContent(index: index, color: .red)
                    } else {
                        Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])   // 빈 칸에 셀을 채움
                    }
                }
            }
            
            GridRow(alignment: .bottom) {
                GridDemoRowCellContent(index: 0, color: .blue)
                Image(systemName: "record.circle.fill")
                    .gridColumnAlignment(.leading)
                Image(systemName: "record.circle.fill")
                Image(systemName: "record.circle.fill")
                Image(systemName: "record.circle.fill")
            }
            
            GridRow {
                ForEach(11...12, id: \.self) { index in
                    GridDemoRowCellContent(index: index, color: .green)
                }
            }
            
            GridDemoRowCellContent(index: 16, color: .red)
            
            GridRow {
                GridDemoRowCellContent(index: 17, color: .orange)
                    .gridCellColumns(2) // 두 개의 열에 걸쳐서 넓이를 가지게 됨
                GridDemoRowCellContent(index: 18, color: .pink)
                    .gridCellColumns(3)
            }
        }
        .padding()
    }
}

struct GridDemoRowCellContent: View {
    
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
    GridDemoRowView()
}
