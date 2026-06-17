//
//  DetailsViewController.swift
//  DetailsFeature
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit
import SwiftUI

public final class DetailsViewController: UIViewController {

    private let presenter: DetailsPresenter

    public init(presenter: DetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        embedSwiftUIView()
    }
}

private extension DetailsViewController {
    func embedSwiftUIView() {
        let hosting = UIHostingController(rootView: DetailsView(presenter: presenter))
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
