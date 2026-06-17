//
//  University+Mock.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation
import DomainKit

extension University {
    static let mock = University(
        id: "1",
        alphaTwoCode: "AE",
        name: "American University of Sharjah",
        country: "United Arab Emirates",
        stateProvince: nil,
        webPages: ["https://www.aus.edu"],
        domains: ["aus.edu"]
    )
}
