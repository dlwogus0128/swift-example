//
//  DocDemoDocument.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/1/24.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType{
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}

struct DocDemoDocument: FileDocument {
    var text: String
    
    init(text: String = "Hello, world!") {
        self.text = text
    }
    
    static var readableContentTypes: [UTType] { [.exampleText] }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
