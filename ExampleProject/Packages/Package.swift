// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    products: [
        .library(name: "Dependencies", targets: ["Dependencies"])
    ],
    dependencies: [
        .package(url: "https://github.com/SerhanAksut/DependencyKit.git", from: "1.1.0")
    ],
    targets: [
        .target(name: "Dependencies", dependencies: [
            .product(name: "FeatureStore", package: "DependencyKit")
        ])
    ]
)
