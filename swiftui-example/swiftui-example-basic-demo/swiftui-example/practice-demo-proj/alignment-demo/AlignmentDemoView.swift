//
//  AlignmentDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct AlignmentDemoView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text("This is some text")
            Text("This is some longer text")
            Text("This is short")
            HStack(alignment: .lastTextBaseline, spacing: 20) {
                Text("This is some text")
                    .font(.largeTitle)
                Text("This is some much longer text")
                    .font(.body)
                Text("This is short")
                    .font(.headline)
            }
            VStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.green)
                    .frame(width: 120, height: 50)
                Rectangle()
                    .foregroundColor(Color.red)
                    .alignmentGuide(.leading, computeValue: {
                        d in d[HorizontalAlignment.trailing] + 20
                    })   // 지정 정렬 가이드
                    .frame(width: 200, height: 50)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: 180, height: 50)
            }
        }
        HStack(alignment: .oneThird) {
            Rectangle()
                .foregroundColor(Color.green)
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(Color.red)
                .alignmentGuide(.oneThird,
                                computeValue: { d in
                    d[VerticalAlignment.top]
                })
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(Color.blue)
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(Color.orange)
                .alignmentGuide(.oneThird, 
                                computeValue: { d in
                    d[VerticalAlignment.bottom]
                })
                .frame(width: 50, height: 200)
        }
//        HStack(alignment: .center, spacing: 20) {
//            Circle()
//                .foregroundColor(Color.purple)
//                .alignmentGuide(.crossAlignment,
//                                computeValue: { d in
//                    d[VerticalAlignment.center]
//                })
//                .frame(width: 100, height: 100)
//            VStack(alignment: .center) {
//                Rectangle()
//                    .foregroundColor(Color.green)
//                    .frame(width: 100, height: 100)
//                Rectangle()
//                    .foregroundColor(Color.red)
//                    .frame(width: 100, height: 100)
//                Rectangle()
//                    .foregroundColor(Color.blue)
//                    .alignmentGuide(.crossAlignment,
//                                    computeValue: { d in
//                        d[VerticalAlignment.center]
//                    })
//                    .frame(width: 100, height: 100)
//                Rectangle()
//                    .foregroundColor(Color.orange)
//                    .frame(width: 100, height: 100)
//            }
//        }
        ZStack(alignment: .myAlignmnet) {
            Rectangle()
                .foregroundColor(Color.green)
                .alignmentGuide(HorizontalAlignment.myAlignment,
                                computeValue: { d in
                    d[.trailing]
                })
                .alignmentGuide(VerticalAlignment.myAlignment,
                                computeValue: { d in
                    d[VerticalAlignment.bottom]
                })
                .frame(width: 100, height: 100)
            
            Rectangle()
                .foregroundColor(Color.red)
                .alignmentGuide(VerticalAlignment.myAlignment,
                                computeValue: { d in
                    d[VerticalAlignment.myAlignment]
                })
                .alignmentGuide(HorizontalAlignment.myAlignment,
                                computeValue: { d in
                    d[HorizontalAlignment.myAlignment]
                })
                .frame(width: 100, height: 100)
            
            Circle()
                .foregroundColor(Color.orange)
                .alignmentGuide(HorizontalAlignment.myAlignment,
                                computeValue: { d in
                    d[.leading]
                })
                .alignmentGuide(VerticalAlignment.myAlignment,
                                computeValue: { d in
                    d[.bottom]
                })
                .frame(width: 100, height: 100)
        }
    }
}

// 새로운 정렬 타입을 이렇게 ㅊ가할 수 있음!!
extension VerticalAlignment {
    private enum OneThird: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d.height / 3
        }   // 뷰 높이의 3분의 1이 반환
    }
    static let oneThird = VerticalAlignment(OneThird.self)
    
    private enum CrossAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    static let crossAlignment = VerticalAlignment(CrossAlignment.self)
    
    enum MyVertical: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }
    static let myAlignment = VerticalAlignment(MyVertical.self)
}

extension HorizontalAlignment {
    enum MyHorizontal: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.center]
        }
    }
    static let myAlignment = HorizontalAlignment(MyHorizontal.self)
}

extension Alignment {
    static let myAlignmnet = Alignment(horizontal: .myAlignment,
                                       vertical: .myAlignment)
}

#Preview {
    AlignmentDemoView()
}
