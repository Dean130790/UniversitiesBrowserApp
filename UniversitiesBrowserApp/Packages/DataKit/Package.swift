// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DataKit",
            targets: ["DataKit"]
        ),
    ],
    dependencies: [
        .package(path: "../DomainKit"),
        .package(path: "../NetworkKit"),
        .package(path: "../PersistenceKit")
    ],
    targets: [
        .target(
            name: "DataKit",
            dependencies: [
                "DomainKit",
                "NetworkKit",
                "PersistenceKit"
            ]
        ),
        .testTarget(
            name: "DataKitTests",
            dependencies: ["DataKit"]
        ),
    ]
)
