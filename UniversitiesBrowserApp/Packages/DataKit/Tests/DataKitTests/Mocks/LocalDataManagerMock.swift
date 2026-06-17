//
//  LocalDataManagerMock.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import DomainKit
import PersistenceKit
@testable import DataKit

final class LocalDataManagerMock: LocalDataManagerProtocol, @unchecked Sendable {
    var cachedUniversities: [University] = []
    var saveError: Error?

    private(set) var saveCalled = false
    private(set) var fetchCalled = false

    func save(universities: [University]) async throws {
        saveCalled = true
        if let saveError {
            throw saveError
        }
        cachedUniversities = universities
    }

    func fetchUniversities() async throws -> [University] {
        fetchCalled = true
        return cachedUniversities
    }
}
