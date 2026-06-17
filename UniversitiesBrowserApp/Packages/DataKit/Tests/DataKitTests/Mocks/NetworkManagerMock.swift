//
//  NetworkManagerMock.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation
import DomainKit
import NetworkKit
@testable import DataKit

final class NetworkManagerMock: NetworkManagerProtocol, @unchecked Sendable {
    var dtos: [UniversityDTO] = []
    var error: Error?

    private(set) var requestCalled = false

    func request<T>(endpoint: Endpoint, responseType: T.Type) async throws -> T where T : Decodable {
        requestCalled = true
        if let error {
            throw error
        }
        return dtos as! T
    }
}
