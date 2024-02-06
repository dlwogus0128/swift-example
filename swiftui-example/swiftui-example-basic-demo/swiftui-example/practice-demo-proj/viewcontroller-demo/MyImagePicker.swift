//
//  MyImagePicker.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/6/24.
//

import SwiftUI

struct MyImagePicker: UIViewControllerRepresentable {
    
    @Binding var imagePickerVisible: Bool
    @Binding var selectedImage: Image?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MyImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePickerVisible: $imagePickerVisible,
                           selectedImage: $selectedImage)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var imagePickerVisible: Bool
        @Binding var selectedImage: Image?
        
        init(imagePickerVisible: Binding<Bool>, selectedImage: Binding<Image?>) {
            _imagePickerVisible = imagePickerVisible    // 여기에서 와일드카드를 쓰는 게 바인딩해서 쓰는 값임을 ..나타내는 관례 같은 것..?
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            selectedImage = Image(uiImage: uiImage)
            imagePickerVisible = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePickerVisible = false
        }
    }
}
//
//#Preview {
//    MyImagePicker()
//}
