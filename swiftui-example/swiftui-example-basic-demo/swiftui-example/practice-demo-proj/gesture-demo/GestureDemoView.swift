//
//  GestureDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import SwiftUI

struct GestureDemoView: View {
    
    @State private var magnification: CGFloat = 1.0
    
    let tap = TapGesture()
        .onEnded { _ in
            print("Tapped")
        }
    
    let longPress = LongPressGesture()  // 디폴트 시간 이상 롱 프레스할 때 감지
        .onEnded { _ in
            print("Long Press")
        }
    
    @GestureState private var offset: CGSize = .zero
    @GestureState private var isLongPress: Bool = false
    
    @State private var dragEnabled: Bool = false
    
    var body: some View {
        Image(systemName: "hand.point.right.fill")
            .gesture(
                TapGesture()    // 탭을 실행할 때마다 클로저 내부 실행
                    .onEnded({ _ in
                        print("Tapped")
                    })
            )
            .padding()
        
        Text("Tap me!")
            .gesture(tap)
            .padding()
        
        Text("Long press me!")
            .gesture(longPress)
            .padding()
        
        // 옵션 키를 누른 상태에서 드래그를 하면 확대됨
//        let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0)
//            .onChanged({ value in   // onChanged 액션 콜백, 얻은 제스처 정보에 따라서 결과값을 도출할 수 있음
//                self.magnification = value
//                print("Magnifying")
//            })
//            .onEnded { _ in
//                print("Gesture Ended")
//            }
//
//        
//        // 해당 제스처를 감지해서 이미지를 키워줄 수 있음
//        return Image(systemName: "hand.point.right.fill")
//            .resizable()
//            .font(.largeTitle)
//            .gesture(magnificationGesture)
//            .frame(width: 100, height: 100)
//            .scaleEffect(magnification)
        
//        let drag = DragGesture()
//            .updating($offset) { dragValue, state, transaction in
//                state = dragValue.translation
//            }
//        
//        // 드래그가 끝나면 자동으로 offset 프로퍼티가 원래 상태로 되돌아가기 때문에 Image뷰가 원상태로 돌아감
//        return Image(systemName: "hand.point.right.fill")
//            .font(.largeTitle)
//            .offset(offset)
//            .gesture(drag)
        
//        let longPressAndDrag = LongPressGesture(minimumDuration: 1.0)
//            .updating($isLongPress) { value, state, transaction in    // 제스처에 대한 정보, 제스처 바인딩 되어 있는 프로퍼티에 대한 참조체, 제스처에 해당하는 애니메이션의 현재 상태를 담고 있는 transaction 객체
//                state = value
//            }
//            .simultaneously(with: DragGesture())
//            .updating($offset) { value, state, transaction in
//                state = value.second?.translation ?? .zero
//            }
//        
//        return Image(systemName: "hand.point.right.fill")
//            .foregroundColor(isLongPress ? Color.red : Color.blue)  // 꾹 누르고 있으면 색이 변함
//            .font(.largeTitle)
//            .offset(offset)
//            .gesture(longPressAndDrag)
        
        let longPressedBeforeDrag = LongPressGesture(minimumDuration: 2.0)
            .onEnded { _ in
                self.dragEnabled = true
            }
            .sequenced(before: DragGesture())
            .updating($offset) { value, state, transaction in
                switch value {
                case .first(true):
                    print("Long press in progress")
                case .second(true, let drag):
                    state = drag?.translation ?? .zero
                default: break
                }
            }
            .onEnded { value in
                self.dragEnabled = true
            }
        
        return Image(systemName: "hand.point.right.fill")
            .foregroundColor(dragEnabled ? Color.green : Color.blue)
            .font(.largeTitle)
            .offset(offset)
            .gesture(longPressedBeforeDrag)
    }
}

//#Preview {
//    GestureDemoView()
//}
