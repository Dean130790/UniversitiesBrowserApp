//
//  RetryPolicy.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation

public struct RetryPolicy: Sendable {
    public let maxRetries: Int
    public let initialDelay: TimeInterval

    public init(maxRetries: Int = 3, initialDelay: TimeInterval = 1) {
        self.maxRetries = maxRetries
        self.initialDelay = initialDelay
    }
}

enum Sleep {
    static func forSeconds(_ seconds: TimeInterval) async throws {
        if #available(iOS 16, *) {
            try await Task.sleep(for: .seconds(seconds))
        } else {
            try await Task.sleep(
                nanoseconds: UInt64(seconds * 1_000_000_000)
            )
        }
    }
}
