//
//  DetailsModuleBuilder.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import DomainKit

@MainActor
public enum DetailsModuleBuilder {
    public static func build(university: University, store: UniversityStore, refreshCoordinator: RefreshCoordinator) -> UIViewController {
        let presenter = DetailsPresenter(university: university, store: store, refreshCoordinator: refreshCoordinator)
        let controller = DetailsViewController(presenter: presenter)
        return controller
    }
}
