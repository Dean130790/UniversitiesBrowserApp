//
//  EmptyStateView.swift
//  CommonUI
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI

public struct EmptyStateView: View {

    private let title: String

    private let subtitle: String?

    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack(spacing: Spacing.medium) {
            Image(systemName:"tray")
                .font(.largeTitle)
            Text(title)
                .font(.headline)
            if let subtitle {
                Text(subtitle)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
