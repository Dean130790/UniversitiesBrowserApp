//
//  ListingInteractorProtocol.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public protocol ListingInteractorProtocol: Sendable {
    func loadUniversities() async throws -> [University]
    func refreshUniversities() async throws -> [University]
}
