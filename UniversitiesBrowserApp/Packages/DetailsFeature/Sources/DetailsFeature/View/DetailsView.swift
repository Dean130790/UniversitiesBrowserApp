//
//  DetailsView.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import SwiftUI

public struct DetailsView: View {

    @ObservedObject var presenter: DetailsPresenter

    public init(presenter: DetailsPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                universityName
                country
                stateProvince
                domains
                webPages
                refreshButton
            }
            .padding()
        }
    }
}

private extension DetailsView {
    var universityName: some View {
        Text(presenter.state.university.name)
            .font(.title2)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension DetailsView {
    var country: some View {
        VStack(alignment: .leading) {
            Text("Country")
            Text(presenter.state.university.country)
        }
    }
}

private extension DetailsView {

    @ViewBuilder
    var stateProvince: some View {
        if let province = presenter.state.university.stateProvince {
            VStack(alignment: .leading) {
                Text("State Province")
                Text(province)
            }
        }
    }
}

private extension DetailsView {
    var domains: some View {
        VStack(alignment: .leading,spacing: 8) {
            Text("Domains")
            ForEach(presenter.state.university.domains, id: \.self) {
                Text($0)
            }
        }
    }
}

private extension DetailsView {
    var webPages: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Web Pages")
            ForEach(presenter.state.university.webPages, id: \.self) {
                Text($0)
            }
        }
    }
}

private extension DetailsView {
    var refreshButton: some View {
        Button("Refresh") {
            Task {
                await presenter.refresh()
            }
        }
    }
}
