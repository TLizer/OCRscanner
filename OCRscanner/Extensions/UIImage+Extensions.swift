//
//  UIImage+Extensions.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

extension UIImage {
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        if size.width > size.height {
            scaledSize.height = size.height / size.width * maxDimension
        } else {
            scaledSize.width = size.width / size.height * maxDimension
        }
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
