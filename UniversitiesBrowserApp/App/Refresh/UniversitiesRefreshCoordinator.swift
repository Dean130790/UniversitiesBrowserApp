//
//  UniversitiesRefreshCoordinator.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit
import ListingFeature

final class UniversitiesRefreshCoordinator: RefreshCoordinator {

    private let interactor: ListingInteractorProtocol

    private let store: UniversityStore

    init( interactor: ListingInteractorProtocol, store: UniversityStore) {
        self.interactor = interactor
        self.store = store
    }

    func refreshUniversities() async {
        do {
            let universities = try await interactor.refreshUniversities()
            store.update(universities: universities)
        } catch {
            print(error)
        }
    }
}
