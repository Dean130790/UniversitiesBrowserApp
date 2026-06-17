//
//  RefreshCoordinatorMock.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import Foundation
import DomainKit
@testable import DetailsFeature

@MainActor
final class RefreshCoordinatorMock: RefreshCoordinator {
    private(set) var refreshCalled = false

    func refreshUniversities() async {
        refreshCalled = true
    }
}
