//
//  ImageLiterals.swift
//  swift-example
//
//  Created by 픽셀로 on 1/4/24.
//

import UIKit

enum ImageLiterals {
    static var pochacoFaceImg: UIImage { .load(named: "pochaco_face_img") }
    static var pochacoImg: UIImage { .load(named: "pochacoImg") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
