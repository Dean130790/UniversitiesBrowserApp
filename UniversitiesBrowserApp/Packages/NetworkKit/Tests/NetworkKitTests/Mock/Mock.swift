//
//  Mock.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

struct Mock: Identifiable, Hashable, Codable {
    let id, title: String
    let details: MockDetails

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case details
    }
}

struct MockDetails: Identifiable, Hashable, Codable {
    let id: String
    let name, address: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
    }
}

extension Mock {
    static let mock1 = Mock(id: "1", title: "Test tilte 1", details: MockDetails(id: "1", name: "Test name 1", address: "Test address 1")
    )

    static let mock2 = Mock(id: "1", title: "Test tilte 2", details: MockDetails(id: "1", name: "Test name 2", address: "Test address 2")
    )

    static let list: [Mock] = [
        .mock1,
        .mock2
    ]

    func toData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Array where Element: Encodable {
    func toData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
