//
//  ListingModuleBuilder.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import DomainKit

@MainActor
public enum ListingModuleBuilder {
    public static func build(interactor: ListingInteractorProtocol, router: ListingRouterProtocol, store: UniversityStore) -> UIViewController {
        let presenter = ListingPresenter(interactor: interactor, router: router, store: store)
        return ListingViewController(presenter: presenter)
    }
}
