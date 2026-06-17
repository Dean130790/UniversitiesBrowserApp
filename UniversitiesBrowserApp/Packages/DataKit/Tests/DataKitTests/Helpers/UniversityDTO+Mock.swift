//
//  UniversityDTO+Mock.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import NetworkKit
@testable import DataKit

extension UniversityDTO {
    static let mock = UniversityDTO(
        country: "United Arab Emirates",
        domains: [
            "aus.edu"
        ],
        name: "American University of Sharjah",
        webPages: [
            "https://www.aus.edu"
        ],
        stateProvince: nil
    )
}
