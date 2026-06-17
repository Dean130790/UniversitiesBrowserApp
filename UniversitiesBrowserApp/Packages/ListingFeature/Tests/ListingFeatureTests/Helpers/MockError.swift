//
//  MockError.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation

enum MockError: LocalizedError {
    case failure
    var errorDescription: String? {
        "failure"
    }
}
