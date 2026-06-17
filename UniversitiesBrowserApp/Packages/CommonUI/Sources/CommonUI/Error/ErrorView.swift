//
//  ErrorView.swift
//  CommonUI
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI

public struct ErrorView: View {

    private let message: String

    private let retryAction: () -> Void

    public init(message: String, retryAction: @escaping () -> Void) {
        self.message = message
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: Spacing.medium) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            Text("Something Went Wrong")
                .font(.headline)
            Text(message)
                .multilineTextAlignment(.center)
            RetryButton(action: retryAction)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
