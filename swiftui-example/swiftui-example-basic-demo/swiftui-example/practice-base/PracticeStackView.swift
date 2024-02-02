//
//  PracticeStackView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

struct PracticeStackView: View {
    
    @State var myLayout: AnyLayout = AnyLayout(VStackLayout())
    
    var body: some View {
        VStack {
            Text("Financial Results")
                .font(.title)
                .padding(.bottom, 15)
            HStack(alignment: .top, spacing: 15) {
                Text("Q1 Sales")
                    .font(.headline)
                Spacer()
                VStack(alignment: .leading) {
                    Text("January")
                    Text("Feburary")
                    Text("March")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("$1000")
                    Text("$200")
                    Text("$3000")
                }
                .padding(5)
            }
            .padding(5)
            myLayout {
                Image(systemName: "goforward.10")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(systemName: "goforward.15")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                Button(action: {
                    myLayout = AnyLayout(HStackLayout())
                }, label: {
                    Text("HStack")
                })
                Button(action: {
                    myLayout = AnyLayout(VStackLayout())
                }, label: {
                    Text("VStack")
                })
            }
            .padding()
            HStack {
                Image(systemName: "airplane")
                Text("Fligt Times: ")
                Text("London")
            }
            .font(.largeTitle)
            .lineLimit(1)   // 텍스트를 몇 줄로 표현할 지 표시 제한 (범위로 둘 수도 있음, numberOfLines)
            .layoutPriority(1)
            Text("Hello World, How are you?")
                .font(.largeTitle)
                .border(Color.black)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100,
                       maxHeight: 100, alignment: .center)  // 프레임의 최대 영역과 최소 영역을 지정할 수 있음
                .edgesIgnoringSafeArea(.all)    // 기본적으로 frame은 safe area를 지키는데 이를 무시
            
        }
        .padding(5)
        // GeometryReader를 사용하여 프레임의 크기를 계산하고 결정할 수도 있음
        GeometryReader { geometry in
            VStack {
                Text("Hello world, how are you?")
                    .font(.largeTitle)
                    .frame(width: geometry.size.width / 2, height: (geometry.size.height / 4) * 3)
                Text("Good Bye World")
                    .font(.largeTitle)
                    .frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
            }
        }
    }
}

#Preview {
    PracticeStackView()
}
