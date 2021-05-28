//
//  OCRScanData.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import Foundation

struct OCRScanData {
    let date: Date
    let imagePath: String
    let text: String?
}

extension OCRScanData {
    init(with scan: OCRScan) {
        self.init(date: scan.date, imagePath: scan.imagePath, text: scan.text)
    }
}
