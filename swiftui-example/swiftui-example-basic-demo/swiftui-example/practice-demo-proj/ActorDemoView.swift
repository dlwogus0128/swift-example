//
//  ActorDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

// 액터 인스턴스에 포함된 데이터는 앱의 다른 코드와 격리됨
// 이 경우, 인스턴스 데이터 (여기에서는 name)를 변경하는 메서드가 호출될 때,
// 다른 곳의 코드에서 해당 메서드를 호출할 수 있게 되기 전에 메서드가 완전히 실행되는 것을 보장함
// -> 여러 작업이 동시에 데이터 변경을 시도하는 것을 막음 (await 구문이 필요함) -> 그렇지만 예외적으로 nonisolation 키워드와 함게 선언된 메서드는 await 없이 호출 가능

actor BuildMessage {
    var message: String = ""
    let greeting = "Hello"
    
    func setName(name: String) {
        self.message = "\(greeting) \(name)"
    }
    
    func someFunction() async {
        let builder = BuildMessage()
        await builder.setName(name: "John Smith")
        let message = await builder.message
        print(message)
    }
    
    nonisolated func getGreeting() -> String {
        return greeting
    }
}

actor TimeStore {
    var timeStamp: [Int: Date] = [:]
    
    func addStamp(task: Int, date: Date) {
        timeStamp[task] = date
    }
    
    func doSometing() async {
        let store = TimeStore()
        
        await withTaskGroup(of: Void.self) { group in
            for i in 1...5 {
                group.addTask {
                    await store.addStamp(task: i, date: await self.takesTooLong())
                }
            }
        }
        
        for (task, date) in await store.timeStamp {
            print("Task = \(task), Date = \(date)")
        }
    }
    
    func takesTooLong() async -> Date {
        sleep(5)
        return Date()
    }
}

struct ActorDemoView: View {
    var builder = BuildMessage()
    
    var body: some View {
        Text("Hello World")
    }
    
    // nonisolated로 선언하니 동기, 비동기 상관 없이 모두에서 호출 가능
    func asyncFunction() async {
        let greeting = builder.getGreeting()
        print(greeting)
    }
    
    func syncFunction() {
        let greeting = builder.getGreeting()
        print(greeting)
    }
}
