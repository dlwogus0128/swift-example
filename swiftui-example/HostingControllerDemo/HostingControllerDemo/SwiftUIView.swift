//
//  SwiftUIView.swift
//  HostingControllerDemo
//
//  Created by 픽셀로 on 2/6/24.
//

import SwiftUI

struct SwiftUIView: View {
    
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Image(systemName: "smiley")
                Text("This is a SwiftUI View")
            }
        }
        .font(.largeTitle)
    }
}

//#Preview {
//    SwiftUIView(text: "Sample Text")
//}
