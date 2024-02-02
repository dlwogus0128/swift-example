//
//  AppStorageView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct UserName: Encodable, Decodable {
    var firstName: String
    var secondName: String
}

struct AppStorageView: View {
    
    @AppStorage("myName") var editorText: String = String()
    
    var body: some View {
        TextEditor(text: $editorText)
            .padding(30)
            .font(.largeTitle)
    }
}
