//
//  MockHTTPClient.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation
@testable import NetworkKit

class MockHTTPClient: HTTPClient, @unchecked Sendable {

    var stubbedData: Data
    var stubbedResponse: URLResponse
    var stubbedError: Error?

    var capturedRequests: [URLRequest]

    init() {
        self.stubbedData = Data()
        self.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        self.capturedRequests = []
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        capturedRequests.append(request)

        if let error = stubbedError {
            throw error
        }
        return (stubbedData, stubbedResponse)
    }

    func upload(for request: URLRequest, data: Data) async throws -> (Data, URLResponse) {
        capturedRequests.append(request)

        if let error = stubbedError {
            throw error
        }
        return (stubbedData, stubbedResponse)
    }

    func download(for request: URLRequest) async throws -> (URL, URLResponse) {
        capturedRequests.append(request)

        if let error = stubbedError {
            throw error
        }
        return (URL(string: "")!, stubbedResponse)
    }
}

// MARK: - Convenience helpers for tests
extension MockHTTPClient {
    func stub(data: Data = Data(), response: URLResponse? = nil, statusCode: Int = 200, error: Error? = nil) {
        stubbedData = data
        stubbedResponse = response == nil ? HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )! : response!
        stubbedError = error
    }
}
