//
//  UniversityEntityMapper.swift
//  PersistenceKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public struct UniversityEntityMapper {
    
    public init() {}
    
    public func map(entity: UniversityEntity) -> University {
        University(id: entity.id, alphaTwoCode: entity.alphaTwoCode, name: entity.name, country: entity.country, stateProvince: entity.stateProvince, webPages: entity.webPages as? [String] ?? [], domains: entity.domains as? [String] ?? [])
    }
}
