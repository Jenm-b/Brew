//
//  CoreDataDrink+CoreDataProperties.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 08/12/2022.
//
//

import Foundation
import CoreData


extension CoreDataDrink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataDrink> {
        return NSFetchRequest<CoreDataDrink>(entityName: "CoreDataDrink")
    }

    @NSManaged public var caffeinated: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var milk: String
    @NSManaged public var name: String
    @NSManaged public var strength: String
    @NSManaged public var sweetener: String
    @NSManaged public var teaSpoonsOfSugar: Int16
    @NSManaged public var user: String
    @NSManaged public var notes: String?
}

extension CoreDataDrink : Identifiable {

}
