//
//  CoreDataFetchingConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 30/06/2022.
//

import CoreData

struct CoreDataFetchingConfiguration {
    let mainContext: NSManagedObjectContext
    let predicate: NSPredicate?
    let sortDescriptors: [NSSortDescriptor]
    let sectionKeyPath: String?

    init(mainContext: NSManagedObjectContext, predicate: NSPredicate? = .none, sortDescriptors: [NSSortDescriptor], sectionKeyPath: String? = .none){
        self.mainContext = mainContext
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
        self.sectionKeyPath = sectionKeyPath
    }
}

extension NSSortDescriptor {
    static let user =  NSSortDescriptor(key: "user", ascending: true)
}
