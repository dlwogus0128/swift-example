//
//  IconCategroy.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import Foundation

struct IconCategroy: Identifiable, Hashable {
    let id = UUID()
    var categoryName: String
    var images: [String]
}
