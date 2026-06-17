//
//  RefreshCoordinator.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation

@MainActor
public protocol RefreshCoordinator: AnyObject {
    func refreshUniversities() async
}
