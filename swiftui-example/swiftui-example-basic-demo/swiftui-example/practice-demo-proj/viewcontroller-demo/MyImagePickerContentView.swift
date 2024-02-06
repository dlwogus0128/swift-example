//
//  MyImagePickerContentView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/6/24.
//

import SwiftUI

struct MyImagePickerContentView: View {
    
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName: "photo")
    
    var body: some View {
        ZStack {
            VStack {
                selectedImage?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button(action: {
                    withAnimation {
                        self.imagePickerVisible.toggle()
                    }
                }, label: {
                    Text("Select an Image")
                })
            }.padding()
            
            if (imagePickerVisible) {
                MyImagePicker(imagePickerVisible: $imagePickerVisible,
                              selectedImage: $selectedImage)
            }
        }
    }
}

#Preview {
    MyImagePickerContentView()
}
