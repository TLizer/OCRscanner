//
//  OCRCoreDataStack.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import CoreData

final class OCRCoreDataStack: CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OCRscanner")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
