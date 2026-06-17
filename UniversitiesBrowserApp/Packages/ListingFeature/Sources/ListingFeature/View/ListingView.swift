//
//  ListingView.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI
import DomainKit
import CommonUI

public struct ListingView: View {

    @ObservedObject var presenter: ListingPresenter

    public init(presenter: ListingPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .task {
                presenter.load()
            }
    }
}

private extension ListingView {

    @ViewBuilder
    var content: some View {
        switch presenter.state {
        case .idle:
            EmptyView()
        case .loading:
            LoadingView()
        case .empty:
            EmptyStateView(title: "No Universities Found")
        case .error(let message):
            ErrorView(message: message, retryAction: { presenter.load() })
        case .loaded(let universities):
            universitiesList(universities)
        }
    }
}

private extension ListingView {
    func universitiesList(_ universities: [University]) -> some View {
        List(universities) { university in
            Button {
                presenter.didSelect(university: university)
            } label: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(university.name)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(university.country)
                        .font(.caption)
                }
            }
        }
        .refreshable {
            await presenter.refreshUniversities()
        }
    }
}
