//
//  LoadingView.swift
//  CommonUI
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI

public struct LoadingView: View {

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Loading...")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
