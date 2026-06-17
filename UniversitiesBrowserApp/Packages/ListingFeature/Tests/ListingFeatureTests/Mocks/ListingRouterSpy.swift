//
//  ListingRouterSpy.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import DomainKit
@testable import ListingFeature

final class ListingRouterSpy: ListingRouterProtocol {
    private(set) var showDetailsCalled = false
    private(set) var selectedUniversity: University?
    
    func showDetails(university: University) {
        showDetailsCalled = true
        selectedUniversity = university
    }
}
