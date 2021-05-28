//
//  NSManagedObjectContext+Extensions.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import CoreData

extension NSManagedObjectContext {
    func objects<T: NSManagedObject>(withType: T.Type, sortDescriptor: NSSortDescriptor? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        if let sortDescriptor = sortDescriptor {
            request.sortDescriptors = [sortDescriptor]
        }
        do {
            return try fetch(request)
        } catch {
            return []
        }
    }
    
    func firstObject<T: NSManagedObject>(with predicate: NSPredicate) -> T? {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        return try? fetch(request).first
    }
}
