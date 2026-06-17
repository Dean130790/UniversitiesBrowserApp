// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DomainKit",
            targets: ["DomainKit"]
        ),
    ],
    targets: [
        .target(
            name: "DomainKit"
        )
    ]
)
