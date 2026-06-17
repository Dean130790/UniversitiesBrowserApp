//
//  Endpoint.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public protocol Endpoint: Sendable {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var body: (any Encodable)? { get }
    var headers: [String: String]? { get }
}
