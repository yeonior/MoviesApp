//
//  DataPersistenceManager.swift
//  MoviesApp
//
//  Created by Ruslan on 29.05.2022.
//

import CoreData

final class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
    }
    
    // MARK: - Properties
    static let shared = DataPersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesAppModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let item = TitleItem(context: context)
        
        item.id = Int64(model.id)
        item.mediaType = model.mediaType
        item.originalName = model.originalName
        item.originalTitle = model.originalTitle
        item.overview = model.overview
        item.posterPath = model.posterPath
        item.releaseDate = model.releaseDate
        item.voteAverage = model.voteAverage
        item.voteCount = Int64(model.voteCount)
        
        if context.hasChanges {
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(DatabaseError.failedToSaveData))
            }
        }
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        let request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
}
