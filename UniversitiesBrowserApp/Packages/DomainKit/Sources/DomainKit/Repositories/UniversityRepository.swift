//
//  UniversityRepository.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public protocol UniversityRepository: Sendable {
    func fetchUniversities(country: String) async throws -> [University]
    func refreshUniversities(country: String) async throws -> [University]
    func cachedUniversities(country: String) async throws -> [University]
}
