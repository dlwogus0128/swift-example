//
//  Persistence.swift
//  swiftui-example-coredata-demo
//
//  Created by 픽셀로 on 2/2/24.
//

import CoreData

// 영구 컨트롤러 생성하기
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Product")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
