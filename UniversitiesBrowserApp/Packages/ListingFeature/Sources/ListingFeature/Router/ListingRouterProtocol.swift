//
//  ListingRouterProtocol.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public protocol ListingRouterProtocol: AnyObject {
    func showDetails(university: University)
}
