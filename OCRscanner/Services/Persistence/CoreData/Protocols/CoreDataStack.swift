//
//  CoreDataStack.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import CoreData

protocol CoreDataStack {
    var persistentContainer: NSPersistentContainer { get }
    var moc: NSManagedObjectContext { get }
}
