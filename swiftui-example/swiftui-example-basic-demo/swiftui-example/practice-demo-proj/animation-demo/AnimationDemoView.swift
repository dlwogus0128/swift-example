//
//  AnimationDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import SwiftUI

struct AnimationDemoView: View {
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var redCircle = false
    @State private var visibility = false
    @State private var isSpinning = true
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        Button(action: { withAnimation(.linear(duration: 2)) {  // 명시적 애니메이션, 해당 클로저 내에서 변경된 프로퍼티에서만 애니메이션이 됨
            self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
        }
            self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
        }, label: {
            Text("Click to animate")
                .scaleEffect(scale) // 회전 효과와 함깨 크기도 조절한다
                .rotationEffect(.degrees(rotation)) // 버튼을 누르면 돌아감
//                .animation(.linear(duration: 1), value: rotation)    // 애니메이션 타임라인의 선형성을 적용, duration으로 애니메이션 시간을 지정할 수도 있음
                // lienar, easeOut, easeIn, easeInOut 등으로 애니메이션 커브를 정할 수 있음
                .animation(.spring(response: 1,
                                   dampingFraction: 0.2,
                                   blendDuration: 0).repeatCount(10, autoreverses: false),  // 애니메이션 반복하기 전에 뷰의 원래 모양을 즉시 되돌려야 하는 경우는 autoreverses를 false로 설정해야 함
                           value: rotation) // 스프링같이 디용~디용~
            
            
        })
        .padding()
        
        Circle()
            .fill(redCircle ? .red : .blue)
            .frame(width: 200, height: 200)
            .onTapGesture {
                withAnimation {
                    redCircle.toggle()  // 버튼을 누를 때마다 foreground color 변경
                }
            }
            .padding()
        
        VStack {
            Toggle(isOn: $visibility.animation(.linear(duration: 2)),   // 이렇게 하면 서서히 나타남
                   label: {
                Text("Toggle Text Views")
            })
            .padding()
            
            if visibility {
                Text("Hello World")
                    .font(.largeTitle)
                    .padding()
            }
            
            if !visibility {
                Text("Goodbye World")
                    .font(.largeTitle)
                    .padding()
            }
            
            Toggle(isOn: $isButtonVisible.animation(.linear(duration: 2)),
                   label: {
                Text("Show/Hide Button")
            })
            .padding()
            
            if isButtonVisible {
                Button(action: {}, 
                       label: {
                    Text("Example Button")
                })
                .font(.largeTitle)
                .transition(.move(edge: .top)) // slide, scale, move 등을 사용해서 전환될 때의 애니메이션을 적용할 수 있음
            }
            
            if !isButtonVisible {
                Text("haha")
                    .transition(.fadeAndMove)
            }
        }
        .padding()
        
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(Color.blue)
                .frame(width: 360, height: 360)
            
            Image(systemName: "forward.fill")
                .font(.largeTitle)
                .offset(y: -180)
                .rotationEffect(.degrees(rotation))
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false),
                            value: rotation)
        }
        .onAppear() {   // 뷰가 나타나는 순간,
            self.isSpinning.toggle()    // isSpinning 상태가 false로 전환되며
            rotation = isSpinning ? 0 : 360 // 회전 각도가 360도로 변경됨
        }
    }
    
}

// AnyTransition 클래스를 확장해서 원하는 애니메이션을 설정해놓을 수 있움
extension AnyTransition {
    static var fadeAndMove: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
}

#Preview {
    AnimationDemoView()
}
