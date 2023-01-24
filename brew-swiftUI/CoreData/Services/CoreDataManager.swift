//
//  PersistenceService.swift
//  brew-core
//
//  Created by Jennifer Munro-Brown on 13/03/2022.
//

import CoreData

final class CoreDataManager<Entity: NSManagedObject> {
    
    typealias ServiceResult = (Result<Bool, Error>) -> Void

    // MARK: - Properties
    private let mainContext: NSManagedObjectContext
    private let writeContext: NSManagedObjectContext

    // MARK: - Init
    init(container: CoreDataContainer) {
        self.mainContext = container.mainContext
        self.writeContext = container.backgroundContext
    }

    func save(with id: UUID, updateEntityHandler: @escaping (Entity) -> Void) async throws {

        try await self.writeContext.perform {

            let entity = try self.fetchOrCreate(with: id, context: self.writeContext)

            updateEntityHandler(entity)

            try self.save(context: self.writeContext)
            print("✅ Entity saved:  \(entity)")
        }
    }

    // MARK: - Delete Methods
    func delete(with id: UUID) async throws {

        try await self.writeContext.perform {
            let entity = try self.fetchOrCreate(with: id, context: self.writeContext)

            self.deleteEntity(entity)

            print("✅ Entity deleted: \(self.writeContext.deletedObjects)")

            try self.writeContext.save()
        }
    }

    func deleteAll() async throws {

        try await writeContext.perform {

            let deleteFetch = Entity.fetchRequest()

            let batchDeleteRequest = NSBatchDeleteRequest(
                fetchRequest: deleteFetch
            )

            batchDeleteRequest.resultType = .resultTypeObjectIDs

            guard let batchDeleteResult = try self.writeContext.execute(batchDeleteRequest)
                    as? NSBatchDeleteResult,
                let entityIds = batchDeleteResult.result as? [NSManagedObjectID] else {
                throw DataServiceError.notDeleted
            }

            let deletedEntities: [AnyHashable: Any] = [
                NSDeletedObjectsKey: entityIds
            ]

            // Updates the main context
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: deletedEntities,
                into: [self.mainContext]
            )

            print("✅ Entities deleted \(self.mainContext.deletedObjects)")
        }
    }

    func delete(with ids: [UUID]) async throws  {
        try await writeContext.perform {

            let deleteFetch = Entity.fetchRequest()

            deleteFetch.predicate = NSPredicate(
                format: "id in %@",
                ids
            )

            let batchDeleteRequest = NSBatchDeleteRequest(
                fetchRequest: deleteFetch
            )

            batchDeleteRequest.resultType = .resultTypeObjectIDs

            guard let batchDeleteResult = try self.writeContext.execute(batchDeleteRequest)
                    as? NSBatchDeleteResult,
                  let entityIds = batchDeleteResult.result as? [NSManagedObjectID] else {
                throw DataServiceError.notDeleted
            }

            let deletedEntities: [AnyHashable: Any] = [
                NSDeletedObjectsKey: entityIds
            ]

            // Updates the main context
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: deletedEntities,
                into: [self.mainContext]
            )

            print("✅ Entities deleted \(self.mainContext.deletedObjects)")
        }
    }
}


// MARK: - Private Properties
private extension CoreDataManager {
    
    func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else {
            return
        }
        
        try context.save()
    }
    
    func fetchOrCreate(with id: UUID, context: NSManagedObjectContext) throws -> Entity {
        guard let fetchRequest = Entity.fetchRequest() as? NSFetchRequest<Entity> else {
            throw DataServiceError.notFound
        }
        
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", id as CVarArg
        )
        
        guard let existingEntity = try context.fetch(fetchRequest).first else {
            return Entity(context: context)
        }
        
        return existingEntity
    }
    
    func deleteEntity<Entity: NSManagedObject>(_ entity: Entity) {
        writeContext.delete(entity)
    }
    
    func delete(with id: NSManagedObjectID) {
        guard let entity = try? writeContext.existingObject(with: id) else {
            return
        }
        
        deleteEntity(entity)
    }
}
