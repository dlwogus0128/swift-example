//
//  DrawDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import SwiftUI

struct DrawDemoView: View {
    
    let colors = Gradient(colors: [Color.red, Color.yellow,
                                   Color.green, Color.blue, Color.purple])
    
    var body: some View {
        Capsule()
//            .stroke(lineWidth: 10)
            .fill(.red.gradient)
            .frame(width: 200, height: 50)
            .padding()
        
        RoundedRectangle(cornerRadius: CGFloat(20))
            .stroke(style: StrokeStyle(lineWidth: 8, dash: [CGFloat(10)]))
            .fill(.blue.shadow(.drop(color: .black, radius: 10)))
            .frame(width: 200, height: 50
            )
            .padding()
        
        Ellipse()   // 타원..
            .stroke(style: StrokeStyle(lineWidth: 20,
                                        dash: [CGFloat(10), CGFloat(5), CGFloat(2)],
                                        dashPhase: CGFloat(10)))
            .fill(.blue.shadow(.inner(color: .white, radius: 15)))
            .frame(width: 250, height: 100)
            .padding()
        
        Ellipse()
            .fill(RadialGradient(gradient: colors,
                                 center: .center,
                                 startRadius: CGFloat(0),
                                 endRadius: CGFloat(300)))
            .overlay(Ellipse()
                .stroke(.blue, lineWidth: 10))
            .frame(width: 250, height: 100)
            .padding()
        
        Path { path in  // 경로를 지정해 도형 그리기
            path.move(to: CGPoint(x: 10, y: 10))
            path.addLine(to: CGPoint(x: 10, y: 350))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.closeSubpath()
        }
        .fill(AngularGradient(gradient: colors,
                              center: .center))
        .padding()
        
        MyShape()
            .fill(LinearGradient(gradient: colors,
                                 startPoint: .topLeading,
                                 endPoint: .trailing))
            .frame(width: 360, height: 350)
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        // 주어진 끝점과 제어점을 사용해 2차 베지어 곡선 추가
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                          control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    DrawDemoView()
}
