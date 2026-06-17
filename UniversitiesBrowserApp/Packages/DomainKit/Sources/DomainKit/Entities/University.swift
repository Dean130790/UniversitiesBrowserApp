//
//  University.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public struct University: Identifiable, Equatable, Sendable {
    public let id: String
    public let alphaTwoCode: String
    public let name: String
    public let country: String
    public let stateProvince: String?
    public let webPages: [String]
    public let domains: [String]

    public init(id: String, alphaTwoCode: String, name: String, country: String, stateProvince: String?, webPages: [String], domains: [String]) {
        self.id = id
        self.alphaTwoCode = alphaTwoCode
        self.name = name
        self.country = country
        self.stateProvince = stateProvince
        self.webPages = webPages
        self.domains = domains
    }
}
