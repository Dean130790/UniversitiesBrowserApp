//
//  FetchUniversitiesUseCase.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public protocol FetchUniversitiesUseCase: Sendable {
    func execute(country: String) async throws -> [University]
}

public final class DefaultFetchUniversitiesUseCase: FetchUniversitiesUseCase {

    private let repository: UniversityRepository

    public init(repository: UniversityRepository) {
        self.repository = repository
    }

    public func execute(country: String) async throws -> [University] {
        try await repository.fetchUniversities(country: country)
    }
}
