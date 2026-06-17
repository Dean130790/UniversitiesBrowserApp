//
//  CoreDataStack.swift
//  PersistenceKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import CoreData

public final class CoreDataStack {

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {
        guard let modelURL = Bundle.module.url(forResource: "PersistenceModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError("Unable to load PersistenceModel.momd from Bundle.module") }

        container = NSPersistentContainer(name: "PersistenceModel", managedObjectModel: model)

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
