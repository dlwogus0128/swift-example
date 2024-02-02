//
//  DemoProjectView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

struct DemoProjectView: View {
    
    var colors: [Color] = [.black, .red, .green, .blue]
    var colorNames = ["Black", "Red", "Green", "Blue"]
    
    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .rotationEffect(.degrees(rotation))
                .animation(.easeInOut(duration: 5), value: rotation)    // 5초 동안 애니메이션 되도록 (자연스럽게 회전)
                .foregroundColor(colors[colorIndex])
            Spacer()
            Divider()
            Slider(value: $rotation, in: 0 ... 360, step: 0.1)
                .padding()
            
            TextField("Enter text here", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker(selection: $colorIndex, label: Text("Color")) {
                ForEach (0 ..< colorNames.count, id: \.self) {
                    Text(colorNames[$0])
                        .foregroundColor(colors[$0])
                }
            }
            .pickerStyle(.palette)
            .padding()
        }
    }
}

#Preview {
    DemoProjectView()
}
