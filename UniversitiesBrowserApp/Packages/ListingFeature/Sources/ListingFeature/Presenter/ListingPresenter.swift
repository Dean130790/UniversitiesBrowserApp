//
//  ListingPresenter.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation
import DomainKit
import Combine

@MainActor
public final class ListingPresenter: ObservableObject, RefreshCoordinator {

    @Published public private(set) var state: ListingViewState = .idle

    private let interactor: ListingInteractorProtocol

    private let router: ListingRouterProtocol

    private let store: UniversityStore

    private var cancellables = Set<AnyCancellable>()

    private var hasFetched = false


    public init(interactor: ListingInteractorProtocol, router: ListingRouterProtocol, store: UniversityStore) {
        self.interactor = interactor
        self.router = router
        self.store = store

        observeStore()
    }
}

private extension ListingPresenter {
    func observeStore() {
        store.$universities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] universities in
                guard let self else { return }
                if universities.isEmpty {
                    self.state = .empty
                } else {
                    self.state = .loaded(universities)
                }
            }
            .store(in: &cancellables)
    }
}

extension ListingPresenter {
    public func load() {
        guard !hasFetched else { return }

        Task {
            state = .loading
            do {
                let universities = try await interactor.loadUniversities()
                updateStore(universities)
                hasFetched = true
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}

extension ListingPresenter {
    public func refreshUniversities() async {
        state = .loading
        do {
            let universities = try await interactor.refreshUniversities()
            updateStore(universities)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

private extension ListingPresenter {
    func updateStore(_ universities: [University]) {
        store.update(universities: universities)
    }
}

extension ListingPresenter {
    public func didSelect(university: University) {
        router.showDetails(university: university)
    }
}
