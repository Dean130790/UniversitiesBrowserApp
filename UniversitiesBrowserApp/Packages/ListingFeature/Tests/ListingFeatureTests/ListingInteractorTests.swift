//
//  ListingInteractorTests.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import XCTest
import DomainKit
@testable import ListingFeature

final class ListingInteractorTests: XCTestCase {
    
    func testLoadUniversitiesCallsFetchUseCase() async throws {
        let fetchUseCase = FetchUniversitiesUseCaseMock()
        fetchUseCase.universities = [.mock]
        let refreshUseCase = RefreshUniversitiesUseCaseMock()
        let interactor = ListingInteractor(country: "United Arab Emirates",  fetchUseCase: fetchUseCase, refreshUseCase: refreshUseCase)
        let universities = try await interactor.loadUniversities()
        
        XCTAssertTrue(fetchUseCase.executeCalled)
        XCTAssertEqual(fetchUseCase.receivedCountry, "United Arab Emirates")
        XCTAssertEqual(universities.count, 1)
    }
    
    func testRefreshUniversitiesCallsRefreshUseCase() async throws {
        let fetchUseCase = FetchUniversitiesUseCaseMock()
        let refreshUseCase = RefreshUniversitiesUseCaseMock()
        refreshUseCase.universities = [.mock]
        let interactor = ListingInteractor(country: "United Arab Emirates", fetchUseCase: fetchUseCase, refreshUseCase: refreshUseCase)
        let universities = try await interactor.refreshUniversities()
        
        XCTAssertTrue(refreshUseCase.executeCalled)
        XCTAssertEqual(refreshUseCase.receivedCountry,"United Arab Emirates")
        XCTAssertEqual(universities.count, 1)
    }
    
    func testLoadUniversitiesPropagatesError() async {
        let fetchUseCase = FetchUniversitiesUseCaseMock()
        fetchUseCase.error = MockError.failure
        let refreshUseCase = RefreshUniversitiesUseCaseMock()
        let interactor = ListingInteractor(country: "United Arab Emirates", fetchUseCase: fetchUseCase, refreshUseCase: refreshUseCase)
        
        do {
            _ = try await interactor.loadUniversities()
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func testRefreshUniversitiesPropagatesError() async {
        let fetchUseCase = FetchUniversitiesUseCaseMock()
        let refreshUseCase = RefreshUniversitiesUseCaseMock()
        refreshUseCase.error = MockError.failure
        let interactor = ListingInteractor( country: "United Arab Emirates", fetchUseCase: fetchUseCase, refreshUseCase: refreshUseCase)
        
        do {
            _ = try await interactor.refreshUniversities()
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
