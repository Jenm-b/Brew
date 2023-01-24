//
//  CoreDataContainer.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/06/2022.
//

import CoreData

final class CoreDataContainer {
    
    private let persistentContainer: NSPersistentContainer
    
    lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext() // context associated with heavy background tasks
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext // context associated with main queue/thread
        context.automaticallyMergesChangesFromParent = true // consumes save notifications from other notifications
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        start()
    }
    
    private func start() {
        persistentContainer.loadPersistentStores { _, error in
            guard let error = error else {
                return
            }
            fatalError("❌ Unable to load persistent stores: \(error.localizedDescription)")
        }
    }
}
