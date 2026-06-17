//
//  UniversityStore.swift
//  DomainKit
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import Foundation
import Combine

@MainActor
public final class UniversityStore: ObservableObject {
    
    @Published public private(set) var universities: [University]
    
    public init(universities: [University] = []) {
        self.universities = universities
    }
    
    public func update(universities: [University]) {
        self.universities = universities
    }
    
    public func university(id: String) -> University? {
        universities.first { $0.id == id }
    }
}
