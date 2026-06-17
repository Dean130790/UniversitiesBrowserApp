//
//  APIClientTests.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Testing
import Foundation
@testable import NetworkKit


@Suite("NetworkManager — Success/Failure Cases")
struct HTTPClientTests {

    
    // MARK: - Fixtures

    private let baseURL = URL(string: "https://api.example.com")!

    let client: MockHTTPClient
    let sut: NetworkManager

    init() {
        client = MockHTTPClient()
        sut = NetworkManager(
            baseURL: baseURL,
            client: client,
            retryPolicy: RetryPolicy(maxRetries: 2, initialDelay: 1)
        )
    }


    // MARK: - NetworkManager — Success Cases

    // MARK: - Decoding

    @Test("200 response returns correctly decoded model")
    func decodesModelOn200() async throws {
        let expected = Mock.list
        try client.stub(data: expected.toData())

        let result = try await sut.request(endpoint: MockEndpoint.test, responseType: [Mock].self)

        #expect(result == expected)
    }

    // MARK: - Request Construction

    @Test func buildsCorrectRequest() async throws {
        try client.stub(data: Mock.mock1.toData())

        _ = try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)

        let captured = try #require(client.capturedRequests.first)
        #expect(captured.httpBody == nil)
        #expect(captured.allHTTPHeaderFields != nil)
        #expect(captured.url?.absoluteString.contains("/test") == true)
        #expect(captured.url?.absoluteString.contains("country=test") == true)
        #expect(captured.url?.absoluteString.contains("https://api.example.com/test?country=test") == true)
    }



    // MARK: - NetworkManager — Error Cases

    // MARK: - HTTP Status Errors

    @Test("401 response throws .unauthorized")
    func unauthorized() async throws {
        client.stub(statusCode: 401)

        await #expect(throws: NetworkError.unauthorized) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
    }

    @Test("404 response throws .notFound")
    func notFound() async throws {
        client.stub(statusCode: 404)

        await #expect(throws: NetworkError.notFound) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
    }

    @Test("5xx responses throw .serverError", arguments: [500, 502, 503, 504])
    func serverErrors(statusCode: Int) async throws {
        client.stub(statusCode: statusCode)

        await #expect(throws: NetworkError.serverError(statusCode)) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
    }

    // MARK: - Response Validation

    @Test("Non-HTTP URLResponse throws .invalidResponse")
    func invalidResponseType() async throws {
        client.stub(response: URLResponse(
            url: baseURL,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        )

        await #expect(throws: NetworkError.invalidResponse) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
    }

    // MARK: - Decoding Errors

    @Test("Wrong JSON shape on 200 throws .decodingError")
    func decodingErrorWrongShape() async throws {
        client.stub(data: Data(#"{"wrong_key": 999}"#.utf8))

        let error = await #expect(throws: NetworkError.self) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
        guard case .decodingError = error else {
            Issue.record("Expected .decodingError, got \(String(describing: error))")
            return
        }
    }

    // MARK: - Network-Level Errors (URLError)

    @Test("URLError.notConnectedToInternet throws .networkError")
    func networkErrorOffline() async throws {
        client.stubbedError = URLError(.notConnectedToInternet)

        let error = await #expect(throws: NetworkError.self) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
        guard case .networkError = error else {
            Issue.record("Expected .networkError, got \(String(describing: error))")
            return
        }
    }

    @Test("URLError.timedOut throws .networkError")
    func networkErrorTimeout() async throws {
        client.stubbedError = URLError(.timedOut)

        let error = await #expect(throws: NetworkError.self) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
        guard case .networkError = error else {
            Issue.record("Expected .networkError, got \(String(describing: error))")
            return
        }
    }

    // MARK: - Cancellation

    @Test("URLError.cancelled surfaces as CancellationError (not wrapped)")
    func cancellationPropagated() async throws {
        client.stubbedError = URLError(.cancelled)

        await #expect(throws: CancellationError.self) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }
    }

    // MARK: - Retry Policy

    @Test("Server error retries exactly maxRetries times then throws")
    func retryExhaustion() async throws {
        client.stub(statusCode: 500)

        await #expect(throws: NetworkError.serverError(500)) {
            try await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)
        }

        // 1 initial attempt + 2 retries = 3 total
        let requestCount = client.capturedRequests.count
        #expect(requestCount == 3, "Expected 3 total attempts, got \(requestCount)")
    }

    @Test("Decoding error is NOT retried")
    func noRetryOnDecodeFailure() async throws {
        client.stub(data: Data("bad".utf8))

        _ = try? await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)

        let requestCount = client.capturedRequests.count
        #expect(requestCount == 1, "Decoding errors must not trigger retry, got \(requestCount) attempts")
    }

    @Test("401 Unauthorized is NOT retried")
    func noRetryOnUnauthorized() async throws {
        client.stub(statusCode: 401)

        _ = try? await sut.request(endpoint: MockEndpoint.test, responseType: Mock.self)

        let requestCount = client.capturedRequests.count
        #expect(requestCount == 1, "401 must not trigger retry, got \(requestCount) attempts")
    }
}
