//
//  OCRDataService.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class OCRDataService: OCRDataProvider {
    private let coreDataStack: CoreDataStack
    private let imageStorage: ImageStorage
    
    init(coreDataStack: CoreDataStack, imageStorage: ImageStorage) {
        self.coreDataStack = coreDataStack
        self.imageStorage = imageStorage
    }
    
    func scans() -> [OCRScanData] {
        let sortDescriptor = NSSortDescriptor(keyPath: \OCRScan.date, ascending: false)
        return coreDataStack.moc
            .objects(withType: OCRScan.self, sortDescriptor: sortDescriptor)
            .map(OCRScanData.init)
    }
    
    func addScan(text: String?, image: UIImage, completion: ((OCRScanData?) -> Void)?) {
        guard let imagePath = try? imageStorage.save(image: image) else {
            completion?(nil)
            return
        }
        let moc = coreDataStack.moc
        moc.perform {
            let scan = OCRScan(context: moc)
            scan.date = Date()
            scan.imagePath = imagePath
            scan.text = text
            try? moc.save()
            completion?(OCRScanData(with: scan))
        }
    }
    
    func removeScan(_ scan: OCRScanData, completion: (() -> Void)?) {
        let moc = coreDataStack.moc
        let predicate = NSPredicate(format: "\(#keyPath(OCRScan.date)) == %@", scan.date as NSDate)
        if let scanToDelete: OCRScan = moc.firstObject(with: predicate) {
            let imagePath = scanToDelete.imagePath
            try? imageStorage.removeImage(atPath: imagePath)
            moc.perform {
                moc.delete(scanToDelete)
                try? moc.save()
                completion?()
            }
        }
    }
}
