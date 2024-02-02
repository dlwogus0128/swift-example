//
//  ChartDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import SwiftUI
import Charts

struct ChartDemoView: View {
    var body: some View {
        let sales = [ (channel: "Retail", data: retailSales),
                      (channel: "Online", data: onlineSales)]
        
        Chart {
            ForEach(sales, id: \.channel) { channels in
                ForEach(channels.data) { sales in
                    PointMark(x: .value("Month", sales.month),
                             y: .value("Total", sales.total)
                    )
                    .foregroundStyle(by: .value("Channel", channels.channel))
                }
            }
        }
        .frame(height: 250)
        .padding()
    }
}
//
//#Preview {
//    ChartDemoView()
//}
