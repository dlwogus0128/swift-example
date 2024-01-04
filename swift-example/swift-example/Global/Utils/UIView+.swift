//
//  UIView+.swift
//  swift-example
//
//  Created by 픽셀로 on 1/3/24.
//

import UIKit

extension UIView {
    /// UIView 여러 개를 인자로 받아서 한 번에 addSubview
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
