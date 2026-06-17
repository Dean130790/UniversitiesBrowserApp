//
//  UniversitiesEndpoint.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation
import NetworkKit

public struct UniversitiesEndpoint: Endpoint {

    public let country: String

    public init(country: String) {
        self.country = country
    }

    public var path: String {
        "/search"
    }

    public var method: HTTPMethod {
        .get
    }

    public var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "country", value: country)]
    }

    public var body: (any Encodable)? {
        nil
    }

    public var headers: [String : String]? {
        nil
    }
}
