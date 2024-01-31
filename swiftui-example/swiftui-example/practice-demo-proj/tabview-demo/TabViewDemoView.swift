//
//  TabViewDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import SwiftUI

struct TabViewDemoView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("First Content View")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Screen One")
                }.tag(1)   // 코드로 현재 선택된 탭을 제어하기 위해 각 탭 아이템마다 태그를 추가해야 함
            Text("Second Content View")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Screen Two")
                }.tag(2)
            Text("Third Content View")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Screen Thrree")
                }.tag(3)
        }
        .font(.largeTitle)
//        .tabViewStyle(PageTabViewStyle())   // 오!! 이거만 추가하면 옆으로 스와이프 해서 뷰 간의 이동을 할 수 있는 뷰 페이징을 구현할 수 있다!!
        
    }
}

#Preview {
    TabViewDemoView()
}
