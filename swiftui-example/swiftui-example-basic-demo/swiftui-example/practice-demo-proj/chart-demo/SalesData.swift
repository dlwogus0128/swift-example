//
//  SalesData.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/31/24.
//

import Foundation

struct SalesInfo: Identifiable {
    var id = UUID()
    var month: String
    var total: Int
}

var retailSales: [SalesInfo] = [
    .init(month: "Jan", total: 5),
    .init(month: "Feb", total: 7),
    .init(month: "March", total: 6),
    .init(month: "April", total: 5),
    .init(month: "May", total: 6),
    .init(month: "June", total: 3),
    .init(month: "July", total: 6)
]

var onlineSales: [SalesInfo] = [
    .init(month: "Jan", total: 2),
    .init(month: "Feb", total: 4),
    .init(month: "March", total: 5),
    .init(month: "April", total: 2),
    .init(month: "May", total: 4),
    .init(month: "June", total: 1),
    .init(month: "July", total: 4)
]
