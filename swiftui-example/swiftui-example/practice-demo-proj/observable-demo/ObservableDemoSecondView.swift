//
//  ObservableDemoSecondView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct ObservableDemoSecondView: View {
    
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        VStack {
            Text("안녕 바보들아")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")
                .font(.headline)
                .padding()
            Button(action: {
                timerData.resetCount()
            }, label: {
                Text("Reset")
            })
        }
    }
}

#Preview {
    ObservableDemoSecondView().environmentObject(TimerData())
}
