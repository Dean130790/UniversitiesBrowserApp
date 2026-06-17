//
//  Untitled.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation

public extension URLSessionConfiguration {

    static func apiSessionConfigurationWithoutURLCache() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default

        // ─── Caching ──────────────────────────────────────────────
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        // ─── Connections ──────────────────────────────────────────
        config.httpMaximumConnectionsPerHost = 4

        // ─── Timeouts ─────────────────────────────────────────────
        config.timeoutIntervalForRequest  = 15
        config.timeoutIntervalForResource = 60

        // ─── Headers ──────────────────────────────────────────────
        config.httpAdditionalHeaders = [
            "Accept":          "application/json",
            "Accept-Encoding": "gzip, deflate, br",
            "X-Client":        "CareerGrid-iOS/1.0"
        ]

        // ─── Cellular & Connectivity ──────────────────────────────
        config.allowsCellularAccess              = true
        config.waitsForConnectivity              = true
        config.timeoutIntervalForResource        = 60

        return config
    }
}
