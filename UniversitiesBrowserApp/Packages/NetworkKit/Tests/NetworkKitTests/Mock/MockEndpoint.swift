//
//  MockEndpoint.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation
@testable import NetworkKit

enum MockEndpoint: Endpoint, Sendable {
    case test

    var path: String {
        switch self {
        case .test:
            return "/test"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .test:
            return [URLQueryItem(name: "country", value: "test")]
        }
    }

    var body: (any Encodable)? { return nil }

    var headers: [String : String]? { return nil }
}
