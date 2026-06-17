//
//  ListingViewState.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public enum ListingViewState {
    case idle
    case loading
    case loaded([University])
    case empty
    case error(String)
}
