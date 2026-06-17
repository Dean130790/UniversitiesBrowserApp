//
//  DomainError.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

public enum DomainError: LocalizedError {
    case noCachedData
    case noInternet
    case invalidResponse
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .noCachedData:
            return "No universities available."
        case .noInternet:
            return "Please check your internet connection."
        case .invalidResponse:
            return "Invalid server response."
        case .unknown:
            return "Something went wrong."
        }
    }
}
