//
//  ObservableDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct ObservableDemoView: View {
    
    @StateObject var timerData: TimerData = TimerData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Timer count = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Button(action: resetCount) {
                    Text("Reset Count")
                }
                .padding()
                
                // 우와 데이터 들고 전달하하면서 넘어가기~~~~~~~~~~~~
                NavigationLink(destination: ObservableDemoSecondView(),
                               label: { Text("Next Screen")})
            }
        }
        .environmentObject(timerData)   // 뷰 간의 데이터 이동할 때~~~~
    }
    
    func resetCount() {
        timerData.resetCount()
    }
}

#Preview {
    ObservableDemoView()
}
