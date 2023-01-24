
import CoreData
import Combine

final class CoreDataFetchingService<Entity: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    private let configuration: CoreDataFetchingConfiguration
    private(set) var onChange: PassthroughSubject<[Entity], Never> = .init()
    private(set) var cancellables: Set<AnyCancellable> = .init([])

    private lazy var fetchedResultsController: NSFetchedResultsController<Entity> = {
        guard let fetchRequest = Entity.fetchRequest() as? NSFetchRequest<Entity> else {
            fatalError("❌ Error - Could not create \(Entity.self) fetch request.")
        }

        fetchRequest.sortDescriptors = configuration.sortDescriptors

        return NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: configuration.mainContext,
            sectionNameKeyPath: configuration.sectionKeyPath,
            cacheName: nil
        )
    }()

    private var fetchedObjects: [Entity] {
        return fetchedResultsController.fetchedObjects ?? []
    }

    init(configuration: CoreDataFetchingConfiguration) {
        self.configuration = configuration
    }

    func start() {
        fetchedResultsController.delegate = self
        fetch()
    }

    private func activateFetchedResultsController() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("❌ Error - Could not perform fetch. \(error.localizedDescription)")
        }
    }

    private func fetch() {
        fetchedResultsController.managedObjectContext.perform {
            if self.fetchedObjects.isEmpty {
                self.activateFetchedResultsController()
            }
            self.onChange.send(self.fetchedObjects)
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        fetch()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetch()
    }
}
