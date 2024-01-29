//
//  ContentView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    
    let carStack = HStack {
        Text("Car Image")
        Image(systemName: "car.fill")
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Text 1")
                    .font(.headline)
                    .foregroundColor(.red)
                Text("Text 2")
                    .font(.custom("Copperplate", size: 70))
                    .padding()
                    .border(Color.red)
                MyHStackView()
                    .font(.largeTitle)
            }
            Text("Text 5")
                .font(.largeTitle)
            carStack
                .imageScale(.large)
            Button(action: buttonPressed) {
                Text("Clicked Me")
                Image(systemName: "square.and.arrow.down")
            }
            MyVStack {
                Text("안녕하세요")
                Text("하하")
                HStack {
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star")
                }
            }
            Label("Welcome to SwiftUI", systemImage: "person.circle.fill")
                .font(.largeTitle)
            Label(title: {
                Text("아아안녕하세요")
                    .font(.title)
            }, icon: { Circle()
                    .fill(Color.blue)
                    .frame(width: 25, height: 25)
            })
        }
    }
    
    func buttonPressed() {
        // 버튼 동작할 코드를 넣는 자리
        print("Button Clicked")
    }
}

// 커스텀 컨테이너 뷰 만들기
// 아래와 같이 일반 Stack을 만들면, 여러 뷰에서 해당 스택이 필요할 때마다 복붙해야 됨
// 이 대 ViewBuilder 클로저 속성을 이용하면 유연성 부여 가능
//struct MyVStack: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("Text Item 1")
//            Text("Text Item 2")
//            Text("Text Item 3")
//        }
//        .font(.largeTitle)
//    }
//}

struct MyVStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 10) {
            content()
        }
        .font(.largeTitle)
    }
}

struct MyHStackView: View {
    var body: some View {
        HStack {
            Text("Text 3")
                .modifier(StandardTitle())
            Text("Text 4")
        }
    }
}

// 커스텀 수정자: .modifier를 활용해 사용 가능
struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.blue)
            .border(Color.gray, width: 0.2)
            .shadow(color: Color.black, radius: 5, x: 0, y: 5)
    }
}

#Preview {
    ContentView()
}
