//
//  UniversityRepositoryImpl.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import DomainKit
import NetworkKit
import PersistenceKit

public final class UniversityRepositoryImpl: UniversityRepository {
    private let networkManager: NetworkManagerProtocol
    private let localDataManager: LocalDataManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol, localDataManager: LocalDataManagerProtocol) {
        self.networkManager = networkManager
        self.localDataManager = localDataManager
    }
    
    public func fetchUniversities(country: String) async throws -> [University] {
        do {
            let endpoint = UniversitiesEndpoint(country: country)
            let dtos: [UniversityDTO] = try await networkManager.request(endpoint: endpoint, responseType: [UniversityDTO].self)
            
            let universities = dtos.map {
                University(id: "\($0.country)-\($0.name)", alphaTwoCode: $0.alphaTwoCode, name: $0.name, country: $0.country, stateProvince: $0.stateProvince, webPages: $0.webPages, domains: $0.domains)
            }
            
            try await localDataManager.save(universities: universities)
            return universities
        } catch {
            let cached = try await localDataManager.fetchUniversities()
            guard !cached.isEmpty else {
                throw DomainError.noCachedData
            }
            return cached
        }
    }
    
    public func refreshUniversities(country: String) async throws -> [University] {
        let endpoint = UniversitiesEndpoint(country: country)
        let dtos: [UniversityDTO] = try await networkManager.request(endpoint: endpoint, responseType: [UniversityDTO].self)
        
        let universities = dtos.map {
            University(id:"\($0.country)-\($0.name)", alphaTwoCode: $0.alphaTwoCode, name: $0.name, country: $0.country, stateProvince: $0.stateProvince, webPages: $0.webPages,domains: $0.domains)
        }
        
        try await localDataManager.save(universities: universities)
        return universities
    }
    
    public func cachedUniversities(country: String) async throws -> [University] {
        try await localDataManager.fetchUniversities()
    }
}
