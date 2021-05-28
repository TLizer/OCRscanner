//
//  ImageStorage.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

protocol ImageStorage {
    func save(image: UIImage) throws -> String
    func removeImage(atPath path: String) throws
}
