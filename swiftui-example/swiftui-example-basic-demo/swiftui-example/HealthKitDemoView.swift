//
//  HealthKitDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 2/27/24.
//

import SwiftUI
import HealthKit

struct HealthKitDemoView: View {
    
    let healthStore = HKHealthStore()
    
    let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
                    HKObjectType.quantityType(forIdentifier: .stepCount)!,
                    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                    HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!])
    
    let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
                     HKObjectType.quantityType(forIdentifier: .stepCount)!,
                     HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                     HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!])
    
    var body: some View {
        VStack() {
            Text("Heart Rate")
                .font(.title)
                .bold()
                .padding()
            Text("값")
                .padding()
            Button("누르면 심박수 측정", action: {
                requestAuthorization()
                getHeartRateData(completion: { result in
                    print("zz")
                })
            })
        }

    }
}

#Preview {
    HealthKitDemoView()
}

extension HealthKitDemoView {
    
    func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: share,
                                              read: read, completion: { ( success, error ) in
            if error != nil {
                print(error.debugDescription)
            } else {
                if success {
                    print("권한이 허락되었습니다.")
                } else {
                    print("권한이 아직 없어요.")
                }
            }
        })
    }
    
    func getHeartRateData(completion: @escaping ([HKSample]) -> Void) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let startDate = Calendar.current.date(byAdding: .hour, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: predicate,
                                  limit: Int(HKObjectQueryNoLimit),
                                  sortDescriptors: [sortDescriptor], resultsHandler: { ( sample, result, error ) in
            guard error == nil else {
                print("error: \(error.debugDescription)")
                return
            }
            guard let resultData = result else {
                print("load result fail")
                return
            }
            DispatchQueue.main.async {
                completion(resultData)
            }
        })
        
        healthStore.execute(query)
    }
}
