//
//  OCRscan.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import CoreData

final class OCRScan: NSManagedObject {
    @NSManaged var date: Date
    @NSManaged var imagePath: String
    @NSManaged var text: String?
}
