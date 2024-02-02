//
//  ConcurrncyDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/29/24.
//

import SwiftUI

enum DurationError: Error {
    case tooLong
    case tooShort
}

struct ConcurrncyDemoView: View {
    var body: some View {
        Button(action: {
            Task {
                // 생성될 때 할당된 우선순위를 식별
//                let priority = Task.currentPriority
//                await doSomething()
                await doSomethingSecond()
            }
        }) {
            Text("Do Something")
        }
    }
    
    func doSomething() async {
        print("Start \(Date())")
        do {
            try await takesTooLong(delay: 10)
        } catch DurationError.tooShort {
            print("Error: Duration too short")
        } catch DurationError.tooLong {
            print("Error: Duration too long")
        } catch {
            print("Unknown error")
        }
        print("End \(Date())")
    }
    
    func doSomethingSecond() async {
        var timeStamps: [Int: Date] = [:]
 
        await withTaskGroup(of: (Int, Date).self) { group in
            for i in 1...5 {
                group.addTask {
//                    let result = await takesTooLongSecond()
//                    print("Completed Task \(i) = \(result)")
                    // 작업이 동시에 실행되었으며, 먼저 생성되었다고 해서 먼저 완료되는 것을 보장하지 않음
//                    timeStamps[i] = await takesTooLongSecond() // 이렇게 하면 동시에 데이터를 접근하는 여러 작업들이 데이터 경쟁을 할 수 있다는 오류가 뜸
                    return(i, await takesTooLongSecond())
                }
            }
            
            for await (task, date) in group {
                timeStamps[task] = date
            }
        }
    }
    
    func takesTooLong(delay: UInt32) async throws {
        if delay < 5 {
            throw DurationError.tooShort
        } else if delay > 20 {
            throw DurationError.tooLong
        }
        
        sleep(5)
        print("Async task completed at \(Date())")
    }
    
    func takesTooLongSecond() async -> Date {
        sleep(5)
        return Date()
    }
}

#Preview {
    ConcurrncyDemoView()
}
