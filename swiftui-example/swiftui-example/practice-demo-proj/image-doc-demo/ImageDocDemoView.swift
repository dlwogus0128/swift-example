//
//  ImageDocDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/2/24.
//

import SwiftUI
import UniformTypeIdentifiers
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageDocDemoView: View {
    
    @Binding var document: ImageDocDemoDocument
    @State private var ciFilter = CIFilter.sepiaTone()
        
    let context = CIContext()
    
    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()    // 해상도 유지
                .aspectRatio(contentMode: .fit) // 비율 유지
                .padding()
            Button(action: {
                filterImage()
            }, label: {
                Text("Filter Image")
            })
            .padding()
        }
    }
    
    func filterImage() {
        ciFilter.intensity = Float(1.0)
        
        let ciImage = CIImage(image: document.image)
        
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = ciFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage,
                                               from: outputImage.extent) {
            document.image = UIImage(cgImage: cgImage)
        }
    }
}

extension UTType {
    static var exampleImage: UTType {
        UTType(importedAs: "com.ebookfrenzy.image")
    }
    
    static var readableContentTypes: [UTType] { [.exampleImage] }
}

//#Preview {
//    ImageDocDemoView(document: .constant(ImageDocDemoDocument()))
//}
