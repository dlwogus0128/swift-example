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
    
    let container: NSPersistentCloudKitContainer    // cloudkit container로 변경
    
    init() {
        container = NSPersistentCloudKitContainer(name: "Product")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        // 잠재적으로 앱의 여러 인스턴스가 동시에 동일한 데이터를 변경할 수 있으므로
        // 충돌이 발생하는 변경 사항은 다음과 같이 처리되도록 병합 정책을 정의
    }
}
