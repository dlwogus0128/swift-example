//
//  SecondTabView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct SecondTabView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .onChange(of: text, perform: { value in
                print("onChange triggered") // 글씨를 쓸 때마다 호출
            })
    }
}
