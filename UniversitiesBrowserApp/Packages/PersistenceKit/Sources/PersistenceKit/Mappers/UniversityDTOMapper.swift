//
//  UniversityDTOMapper.swift
//  PersistenceKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit
import NetworkKit

public struct UniversityDTOMapper {

    public init() {}

    public func map(dto: UniversityDTO) -> University {
        University(id: "\(dto.country)-\(dto.name)", alphaTwoCode: dto.alphaTwoCode, name: dto.name, country: dto.country, stateProvince: dto.stateProvince, webPages: dto.webPages, domains: dto.domains)
    }
}
