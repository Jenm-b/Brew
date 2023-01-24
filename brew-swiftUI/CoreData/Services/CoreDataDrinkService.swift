//
//  CoreDataDrinkService.swift
//  brew-core
//
//  Created by Jennifer Munro-Brown on 01/02/2022.
//

import CoreData
import Combine

final class CoreDataDrinkService: DrinkService {

    static let shared = CoreDataDrinkService()

    lazy var drinksPublisher: AnyPublisher<[Drink], Never> = {
        coreDataFetchingService
            .onChange
            .print()
            .map { coreDataDrinks in
                coreDataDrinks.map {
                    Drink(CDDrink: $0)
                }
            }
            .eraseToAnyPublisher()
    }()

    private let coreDataManager: CoreDataManager<CoreDataDrink>
    private let coreDataFetchingService: CoreDataFetchingService<CoreDataDrink>

    private(set) var cancellables: Set<AnyCancellable> = .init()

    init(container: CoreDataContainer = CoreDataContainer(containerName: "CoreDataDrink")) {
        self.coreDataManager = CoreDataManager(container: container)
        self.coreDataFetchingService = CoreDataFetchingService(configuration: CoreDataFetchingConfiguration(mainContext: container.mainContext, sortDescriptors: [.user]))
    }

    func fetch() {
        coreDataFetchingService.start()
    }
    
    func save(object: Drink) async throws {
        try await coreDataManager.save(with: object.id, updateEntityHandler: { managedObject in
            managedObject.id = object.id
            managedObject.name = object.name.rawValue
            managedObject.user = object.user
            managedObject.milk = object.milk.rawValue
            managedObject.sweetener = object.sweetener.rawValue
            managedObject.caffeinated = object.caffeinated
            managedObject.strength = object.strength.rawValue
            managedObject.teaSpoonsOfSugar = Int16(object.teaSpoonsSugar)
            managedObject.notes = object.notes
            managedObject.date = object.dateCreated
        })
    }
        
    func delete(object: Drink) async throws {
        try await coreDataManager.delete(with: object.id)
    }

    func delete(objects: [Drink]) async throws {
        try await coreDataManager.delete(with: objects.map{ $0.id} )
    }
    
    func deleteAll() async throws {
        try await coreDataManager.deleteAll()
    }
}
