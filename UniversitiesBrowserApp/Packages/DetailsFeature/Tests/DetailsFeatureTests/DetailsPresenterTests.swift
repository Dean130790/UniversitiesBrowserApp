//
//  DetailsPresenterTests.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import XCTest
import DomainKit
@testable import DetailsFeature

@MainActor
final class DetailsPresenterTests: XCTestCase {

    func testInitialStateUsesProvidedUniversity() {
        let university = University.mock
        let store = UniversityStore()
        let coordinator = RefreshCoordinatorMock()

        let presenter = DetailsPresenter(
            university: university,
            store: store,
            refreshCoordinator: coordinator
        )

        XCTAssertEqual(presenter.state.university.id, university.id)
        XCTAssertEqual(presenter.state.university.name, university.name)
    }

    func testRefreshCallsCoordinator() async {
        let store = UniversityStore()
        let coordinator = RefreshCoordinatorMock()

        let presenter = DetailsPresenter(
            university: .mock,
            store: store,
            refreshCoordinator: coordinator
        )

        await presenter.refresh()
        XCTAssertTrue(coordinator.refreshCalled)
    }

    func testStoreUpdateRefreshesState() async {
        let original = University.mock
        let store = UniversityStore()
        store.update(
            universities: [original]
        )

        let coordinator = RefreshCoordinatorMock()

        let presenter = DetailsPresenter(
            university: original,
            store: store,
            refreshCoordinator: coordinator
        )

        let updated = University(
            id: original.id,
            alphaTwoCode: original.alphaTwoCode,
            name: "Updated University",
            country: original.country,
            stateProvince: original.stateProvince,
            webPages: original.webPages,
            domains: original.domains
        )

        store.update(universities: [updated])

        await Task.yield()

        XCTAssertEqual(presenter.state.university.name, "Updated University")
    }

    func testStoreUpdateWithDifferentUniversityDoesNotChangeState() async {
        let original = University.mock
        let store = UniversityStore()
        store.update(universities: [original])

        let coordinator = RefreshCoordinatorMock()

        let presenter = DetailsPresenter(
            university: original,
            store: store,
            refreshCoordinator: coordinator
        )

        let differentUniversity = University(
            id: "different-id",
            alphaTwoCode: "AE",
            name: "Another University",
            country: "United Arab Emirates",
            stateProvince: nil,
            webPages: ["https://test.edu"],
            domains: ["test.edu"]
        )

        store.update(universities: [differentUniversity])

        await Task.yield()

        XCTAssertEqual(presenter.state.university.id, original.id)
        XCTAssertEqual(presenter.state.university.name, original.name)
    }
}
