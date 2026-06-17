//
//  AppListingRouter.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import DomainKit
import ListingFeature
import DetailsFeature

@MainActor
final class AppListingRouter: ListingRouterProtocol {

    weak var navigationController: UINavigationController?

    private let store: UniversityStore

    private let refreshCoordinator: RefreshCoordinator

    init(navigationController: UINavigationController, store: UniversityStore, refreshCoordinator: RefreshCoordinator) {
        self.navigationController = navigationController
        self.store = store
        self.refreshCoordinator = refreshCoordinator
    }
}

extension AppListingRouter {
    func showDetails(university: University) {
        let details = DetailsModuleBuilder.build(university: university, store: store, refreshCoordinator: refreshCoordinator)
        navigationController?.pushViewController(details, animated: true)
    }
}
