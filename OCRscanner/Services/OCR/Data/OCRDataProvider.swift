//
//  OCRDataProvider.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

protocol OCRDataProvider {
    func scans() -> [OCRScanData]
    func addScan(text: String?, image: UIImage, completion: ((OCRScanData?) -> Void)?)
    func removeScan(_ scan: OCRScanData, completion: (() -> Void)?)
}
