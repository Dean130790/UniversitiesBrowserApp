//
//  LocalDataManager.swift
//  PersistenceKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import CoreData
import DomainKit

public protocol LocalDataManagerProtocol: Sendable {
    func save(universities: [University]) async throws
    func fetchUniversities() async throws -> [University]
}

public actor LocalDataManager: LocalDataManagerProtocol {
    private let stack: CoreDataStack
    
    public init(stack: CoreDataStack) {
        self.stack = stack
    }
}

extension LocalDataManager {
    public func save(universities: [University]) async throws {
        let context = stack.container.newBackgroundContext()
        
        do {
            try await context.perform {
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UniversityEntity")
                let delete = NSBatchDeleteRequest(fetchRequest: fetch)
                try context.execute(delete)
                
                for university in universities {
                    let entity = UniversityEntity(context: context)
                    entity.id = university.id
                    entity.name = university.name
                    entity.country = university.country
                    entity.stateProvince = university.stateProvince
                    entity.domains = university.domains as NSArray
                    entity.webPages = university.webPages as NSArray
                }
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension LocalDataManager {
    public func fetchUniversities() async throws -> [University] {
        let context = stack.container.viewContext
        return try await context.perform {
            let request = UniversityEntity.fetchRequest()
            let entities = try context.fetch(request)
            return entities.map { UniversityEntityMapper().map(entity: $0) }
        }
    }
}
