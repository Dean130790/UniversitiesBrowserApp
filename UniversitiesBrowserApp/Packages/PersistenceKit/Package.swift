// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistenceKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PersistenceKit",
            targets: ["PersistenceKit"]
        ),
    ],
    dependencies: [
        .package(path: "../DomainKit"),
        .package(path: "../NetworkKit")
    ],
    targets: [
        .target(
            name: "PersistenceKit",
            dependencies: [
                "DomainKit",
                "NetworkKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
