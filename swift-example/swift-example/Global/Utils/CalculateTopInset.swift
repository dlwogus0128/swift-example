//
//  calculateTopInset.swift
//  swift-example
//
//  Created by 픽셀로 on 1/4/24.
//

import UIKit



public extension UIViewController {
    func calculateTopInset() -> CGFloat {
        let windows = UIApplication.shared.windows[0]
        let topInset = windows.safeAreaInsets.top
        
        if UIDevice.current.hasNotch {
            return topInset * -1
        } else {
            return -44
        }
    }
    
    func safeAreaBottomInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = self.view.window
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
}

/**
 
 - Description:
 
 해당 기기가, notch를 가지고 있는지 bottom safe area inset를 계산해서 판단하는 연산 프로퍼티입니다.
 
 */

public extension UIDevice {
    var hasNotch: Bool {
        UIScreen.main.bounds.height > 736 ? true : false
    }
}
