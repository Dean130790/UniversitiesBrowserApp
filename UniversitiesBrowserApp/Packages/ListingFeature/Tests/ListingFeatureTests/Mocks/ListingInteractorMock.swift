//
//  ListingInteractorMock.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import DomainKit
@testable import ListingFeature

final class ListingInteractorMock: ListingInteractorProtocol, @unchecked Sendable {
    var universities: [University] = []
    var error: Error?
    
    private(set) var loadCalled = false
    private(set) var refreshCalled = false
    
    func loadUniversities() async throws -> [University] {
        loadCalled = true
        if let error {
            throw error
        }
        return universities
    }
    
    func refreshUniversities() async throws -> [University] {
        refreshCalled = true
        if let error {
            throw error
        }
        return universities
    }
}
