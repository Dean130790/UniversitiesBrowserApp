//
//  FetchUniversitiesUseCaseMock.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import DomainKit

final class FetchUniversitiesUseCaseMock: FetchUniversitiesUseCase, @unchecked Sendable {
    var universities: [University] = []
    var error: Error?
    
    private(set) var executeCalled = false
    private(set) var receivedCountry: String?
    
    func execute(country: String) async throws -> [University] {
        executeCalled = true
        receivedCountry = country
        if let error {
            throw error
        }
        return universities
    }
}
