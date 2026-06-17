//
//  UniversityDTO.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public struct UniversityDTO: Codable, Sendable {
    public let alphaTwoCode: String
    public let country: String
    public let domains: [String]
    public let name: String
    public let webPages: [String]
    public let stateProvince: String?

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case country
        case domains
        case name
        case webPages = "web_pages"
        case stateProvince = "state-province"
    }

    public init(alphaTwoCode: String, country: String, domains: [String], name: String, webPages: [String], stateProvince: String? = nil) {
        self.alphaTwoCode = alphaTwoCode
        self.country = country
        self.domains = domains
        self.name = name
        self.webPages = webPages
        self.stateProvince = stateProvince
    }
}
