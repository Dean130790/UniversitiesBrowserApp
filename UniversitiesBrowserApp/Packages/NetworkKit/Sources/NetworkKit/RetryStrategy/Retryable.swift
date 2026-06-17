//
//  Retryable.swift
//  NetworkKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation

protocol Retryable {
    func shouldRetry(for error: Error) -> Bool
}
