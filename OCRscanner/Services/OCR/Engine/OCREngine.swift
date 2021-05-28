//
//  OCRAnalyzer.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

protocol OCREngine {
    func analyze(image: UIImage, completion: @escaping (String?) -> Void)
}
