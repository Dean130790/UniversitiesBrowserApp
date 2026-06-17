//
//  DependencyContainer.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation
import DomainKit
import DataKit
import NetworkKit
import PersistenceKit

final class DependencyContainer {

    lazy var networkManager: NetworkManager = { NetworkManager(baseURL: URL(string: Constant.baseURL)!, client: URLSessionHTTPClient()) }()

    lazy var localDataManager = { LocalDataManager(stack: CoreDataStack()) }()

    lazy var universityRepository: UniversityRepository = { UniversityRepositoryImpl(networkManager: networkManager, localDataManager: localDataManager) }()

    lazy var universityStore = { UniversityStore() }()
}
