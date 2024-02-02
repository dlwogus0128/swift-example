//
//  DemoData.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import Foundation
import Combine

class DemoData: ObservableObject {
    @Published var userCount = 0
    @Published var currentUser = ""
    
    init() {
        // 데이터를 초기화하기 위한 코드
        updateData()
    }
    
    func updateData() {
        // 데이터를 최신 상태로 유지하기 위한 코드
    }
}
