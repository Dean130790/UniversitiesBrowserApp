//
//  RootModuleBuilder.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import DomainKit
import ListingFeature

enum RootModuleBuilder {

    static func build(navigationController: UINavigationController, container: DependencyContainer) -> UIViewController {

        let fetchUseCase = DefaultFetchUniversitiesUseCase(repository: container.universityRepository)

        let refreshUseCase = DefaultRefreshUniversitiesUseCase(repository: container.universityRepository)

        let interactor = ListingInteractor(country: "United Arab Emirates", fetchUseCase: fetchUseCase, refreshUseCase: refreshUseCase)

        let refreshCoordinator = UniversitiesRefreshCoordinator(interactor: interactor, store: container.universityStore)

        let router = AppListingRouter(navigationController: navigationController, store: container.universityStore, refreshCoordinator: refreshCoordinator)

        return ListingModuleBuilder.build(interactor: interactor, router: router, store: container.universityStore)
    }
}
