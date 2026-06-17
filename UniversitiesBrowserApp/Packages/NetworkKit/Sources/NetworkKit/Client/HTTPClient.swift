//
//  HTTPClient.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public protocol HTTPClient: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
