//
//  ListingPresenterTests.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import XCTest
import DomainKit
@testable import ListingFeature

@MainActor
final class ListingPresenterTests: XCTestCase {

    func testLoadSuccessUpdatesStateToLoaded() async throws {
        let interactor = ListingInteractorMock()
        interactor.universities = [.mock]
        let router = ListingRouterSpy()
        let store = UniversityStore()

        let presenter = ListingPresenter(
            interactor: interactor,
            router: router,
            store: store
        )

        presenter.load()
        try await Sleep.forSeconds(100)

        XCTAssertTrue(interactor.loadCalled)
        guard case let .loaded(universities) = presenter.state else {
            XCTFail("Expected loaded state")
            return
        }
        XCTAssertEqual(universities.count, 1)
    }

    func testLoadFailureUpdatesStateToError() async throws {
        let interactor = ListingInteractorMock()
        interactor.error = MockError.failure
        let router = ListingRouterSpy()
        let store = UniversityStore()

        let presenter = ListingPresenter(
            interactor: interactor,
            router: router,
            store: store
        )

        presenter.load()
        try await Sleep.forSeconds(100)

        guard case .error = presenter.state else {
            XCTFail("Expected error state")
            return
        }
    }

    func testLoadEmptyResultUpdatesStateToEmpty() async throws {
        let interactor = ListingInteractorMock()
        let router = ListingRouterSpy()
        let store = UniversityStore()

        let presenter = ListingPresenter(
            interactor: interactor,
            router: router,
            store: store
        )

        presenter.load()
        try await Sleep.forSeconds(100)
        
        guard case .empty = presenter.state else {
            XCTFail("Expected empty state")
            return
        }
    }

    func testRefreshSuccessUpdatesStateToLoaded() async {
        let interactor = ListingInteractorMock()
        interactor.universities = [.mock]
        let router = ListingRouterSpy()
        let store = UniversityStore()

        let presenter = ListingPresenter(
            interactor: interactor,
            router: router,
            store: store
        )

        await presenter.refreshUniversities()
        XCTAssertTrue(interactor.refreshCalled)
        guard case let .loaded(universities) = presenter.state else {
            XCTFail("Expected loaded state")
            return
        }
        XCTAssertEqual(universities.count, 1)
    }

    func testDidSelectNavigatesToDetails() {
        let interactor = ListingInteractorMock()
        let router = ListingRouterSpy()
        let store = UniversityStore()

        let presenter = ListingPresenter(
            interactor: interactor,
            router: router,
            store: store
        )

        presenter.didSelect(university: .mock)
        XCTAssertTrue(router.showDetailsCalled)
        XCTAssertEqual(router.selectedUniversity?.name, University.mock.name)
    }
}

enum Sleep {
    static func forSeconds(_ milliseconds: TimeInterval) async throws {
        if #available(iOS 16, *) {
            try await Task.sleep(for: .milliseconds(milliseconds))
        } else {
            try await Task.sleep(
                nanoseconds: UInt64(milliseconds * 1_000_000)
            )
        }
    }
}
