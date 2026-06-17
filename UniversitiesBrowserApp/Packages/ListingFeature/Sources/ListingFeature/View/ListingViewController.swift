//
//  ListingViewController.swift
//  ListingFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import SwiftUI

public final class ListingViewController: UIViewController {

    private let presenter: ListingPresenter

    public init(presenter: ListingPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Universities"
        embedSwiftUIView()
    }
}

private extension ListingViewController {
    func embedSwiftUIView() {
        let hosting = UIHostingController(rootView: ListingView(presenter: presenter))
        addChild(hosting)
        view.addSubview(hosting.view)

        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hosting.didMove(toParent: self)
    }
}
