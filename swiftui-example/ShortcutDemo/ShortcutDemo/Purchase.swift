//
//  Purchase.swift
//  ShortcutDemo
//
//  Created by Neil Smyth on 7/29/22.
//

import SwiftUI

struct Purchase: Codable, Identifiable {
    var id = UUID()
    var symbol: String
    var quantity: String
    var timestamp: String
}
