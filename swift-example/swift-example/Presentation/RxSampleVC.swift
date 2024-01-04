//
//  RxSampleVC.swift
//  swift-example
//
//  Created by 픽셀로 on 2024/01/03.
//

import UIKit

import RxSwift
import RxCocoa

final class RxSampleVC: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        /// Subscribe: Observable이 제대로 동작하는지 확인하기 위한  부분
        
        checkArrayObservable(items: [1, 3, 4, 5, 0, 8])
            .subscribe { event in
                switch event {
                case .next(let value):
                    print(value)
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            }
            .disposed(by: self.disposeBag)  // 구독을 해제하는 것
    }
}

extension RxSampleVC {
    /// 배열의 엘리멘트 중 0이 나오면 에러가 나는 Observable
    private func checkArrayObservable(items: [Int]) -> Observable<Int> {    // items를 입력 받아 정수 제네릭 타입 Observable을 return
        return Observable<Int>.create { observer -> Disposable in   // observer를 파라미터로 받고, Dispoable을 return하는 Observable을 return
            
            for item in items {
                if item == 0 {
                    observer.onError(NSError(domain: "ERROR: value is zero.", code: 0, userInfo: nil))  // error
                    break
                }
                
                observer.onNext(item)   // next
                
                sleep(1)
            }
            
            observer.onCompleted()  // completed
            
            return Disposables.create()
        }
    }
}

