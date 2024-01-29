//
//  PracticeStatePropertyView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

struct PracticeStatePropertyView: View {
    @State private var userName = ""
    @State private var wifiEnabled = false // 추가
    
    @StateObject var demoData: DemoData = DemoData()
    // @ObservedObject랑 @StateObject는 상호 교환 가능함
    
    var body: some View {
        VStack {
            Toggle(isOn: $wifiEnabled) {
                Text("Enable Wi-Fi")
            }
            TextField("Enter user name", text: $userName)
            Text(userName)
            WifiImageView(wifiEnabled: $wifiEnabled)
            Text("\(demoData.currentUser), you are user number \(demoData.userCount)")
        }
    }
    
    
}

struct WifiImageView: View {
    @Binding var wifiEnabled: Bool // 상위 뷰에서 이 뷰를 부를 때, 해당 변수를 파라미터 느낌으로 받아옴
    
    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}

#Preview {
    PracticeStatePropertyView(demoData: DemoData())
}
