//
//  UniversityRepositoryImplTests.swift
//  DataKit
//
//  Created by Yatharth Wadekar on 17/06/26.
//

import XCTest
import DomainKit
@testable import DataKit

final class UniversityRepositoryImplTests: XCTestCase {

    func testFetchUniversitiesSuccessReturnsNetworkData() async throws {
        let network = NetworkManagerMock()
        network.dtos = [.mock]

        let local = LocalDataManagerMock()

        let repository = UniversityRepositoryImpl(networkManager: network, localDataManager: local)
        let universities = try await repository.fetchUniversities(country: "United Arab Emirates")

        XCTAssertTrue(network.requestCalled)
        XCTAssertTrue(local.saveCalled)
        XCTAssertEqual(universities.count,1)
    }

    func testFetchUniversitiesFailureReturnsCachedData() async throws {
        let network = NetworkManagerMock()
        network.error = MockError.failure

        let local = LocalDataManagerMock()
        local.cachedUniversities = [.mock]

        let repository = UniversityRepositoryImpl(networkManager: network, localDataManager: local)
        let universities = try await repository.fetchUniversities(country: "United Arab Emirates")

        XCTAssertTrue(local.fetchCalled)
        XCTAssertEqual(universities.count, 1)
    }

    func testFetchUniversitiesFailureWithoutCacheThrows() async {
        let network = NetworkManagerMock()
        network.error = MockError.failure

        let local = LocalDataManagerMock()

        let repository = UniversityRepositoryImpl(networkManager: network, localDataManager: local)

        do {
            _ = try await repository.fetchUniversities(country:"United Arab Emirates")
            XCTFail("Expected error")
        } catch let error as DomainError {
            XCTAssertEqual(error, .noCachedData)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testRefreshUniversitiesReturnsFreshData() async throws {
        let network = NetworkManagerMock()
        network.dtos = [.mock]

        let local = LocalDataManagerMock()

        let repository = UniversityRepositoryImpl(networkManager: network, localDataManager: local)
        let universities = try await repository.refreshUniversities(country:"United Arab Emirates")

        XCTAssertTrue(network.requestCalled)
        XCTAssertTrue(local.saveCalled)
        XCTAssertEqual(universities.count, 1)
    }
}
