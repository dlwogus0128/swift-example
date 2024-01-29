//
//  SpeedControlView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

class SpeedSetting: ObservableObject {
    @Published var speed = 0.0
}

struct SpeedControlView: View {
    @EnvironmentObject var speedsetting: SpeedSetting
    
    var body: some View {
        Slider(value: $speedsetting.speed, in: 0...100)
    }
}

struct SpeedDisplayView: View {
    @EnvironmentObject var speedsetting: SpeedSetting
    
    var body: some View {
        Text("Speed = \(speedsetting.speed)")
    }
}
