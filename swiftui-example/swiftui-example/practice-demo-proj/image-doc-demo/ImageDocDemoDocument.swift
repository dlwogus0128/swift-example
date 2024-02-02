//
//  ImageDocDemoDocument.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/2/24.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

struct ImageDocDemoDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.exampleImage] }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
            let decodeImage: UIImage = UIImage(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        image = decodeImage
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = image.pngData()!
        return .init(regularFileWithContents: data)
    }
    
    var image: UIImage = UIImage()
    
    init() {
        if let image = UIImage(named: "cascadefalls") {
            self.image = image
        } else {
            self.image = UIImage()
        }
    }
}
