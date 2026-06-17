//
//  ListingInteractor.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public final class ListingInteractor: ListingInteractorProtocol {

    private let fetchUseCase: FetchUniversitiesUseCase

    private let refreshUseCase: RefreshUniversitiesUseCase

    private let country: String

    public init(country: String, fetchUseCase: FetchUniversitiesUseCase, refreshUseCase: RefreshUniversitiesUseCase) {
        self.country = country
        self.fetchUseCase = fetchUseCase
        self.refreshUseCase = refreshUseCase
    }

    public func loadUniversities() async throws -> [University] {
        try await fetchUseCase.execute(country: country)
    }

    public func refreshUniversities() async throws -> [University] {
        try await refreshUseCase.execute(country: country)
    }
}
