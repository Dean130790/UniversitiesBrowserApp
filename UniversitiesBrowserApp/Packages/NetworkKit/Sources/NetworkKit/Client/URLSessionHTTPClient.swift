//
//  URLSessionHTTPClient.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init() {
        self.session = URLSession(configuration: .apiSessionConfigurationWithoutURLCache())
    }
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
