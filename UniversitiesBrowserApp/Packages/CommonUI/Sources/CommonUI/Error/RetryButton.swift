//
//  RetryButton.swift
//  CommonUI
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI

public struct RetryButton: View {

    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text("Try Again")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .frame(height: UIConstants.buttonHeight)
    }
}
