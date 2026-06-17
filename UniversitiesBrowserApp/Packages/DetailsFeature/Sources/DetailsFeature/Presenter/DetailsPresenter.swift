//
//  DetailsPresenter.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation
import DomainKit
import Combine

@MainActor
public final class DetailsPresenter: ObservableObject {

    @Published public private(set) var state: DetailsViewState

    private let store: UniversityStore

    private let refreshCoordinator: RefreshCoordinator

    private let universityID: String

    private var cancellables = Set<AnyCancellable>()

    public init(university: University, store: UniversityStore, refreshCoordinator: RefreshCoordinator) {
        self.state = DetailsViewState(university: university)
        self.universityID = university.id
        self.store = store
        self.refreshCoordinator = refreshCoordinator

        observeStore()
    }
}

private extension DetailsPresenter {
    func observeStore() {
        store.$universities
            .sink { [weak self] universities in
                guard let self else { return }
                guard let updated = universities.first(where: { $0.id == self.universityID }) else { return}
                self.state = DetailsViewState(university: updated)
            }
            .store(
                in: &cancellables
            )
    }
}

extension DetailsPresenter {
    public func refresh() async {
        await refreshCoordinator.refreshUniversities()
    }
}
