//
//  DetailsViewState.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import DomainKit

public struct DetailsViewState {
    
    public let university: University
    
    public init(university: University) {
        self.university = university
    }
}
