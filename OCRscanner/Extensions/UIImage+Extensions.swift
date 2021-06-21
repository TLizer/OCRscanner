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
    
    func normalizeOrientation() -> UIImage? {
        if (self.imageOrientation == .up) {
            return self;
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
}
