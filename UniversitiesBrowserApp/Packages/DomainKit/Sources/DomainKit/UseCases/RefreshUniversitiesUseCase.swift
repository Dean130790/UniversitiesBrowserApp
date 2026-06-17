//
//  RefreshUniversitiesUseCase.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public protocol RefreshUniversitiesUseCase: Sendable {
    func execute(country: String) async throws -> [University]
}

public final class DefaultRefreshUniversitiesUseCase: RefreshUniversitiesUseCase {

    private let repository: UniversityRepository

    public init(repository: UniversityRepository) {
        self.repository = repository
    }

    public func execute(country: String) async throws -> [University] {
        try await repository.refreshUniversities(country: country)
    }
}
