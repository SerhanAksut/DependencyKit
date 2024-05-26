// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    products: [
        .library(name: "FeatureInterface", targets: ["FeatureInterface"])
    ],
    dependencies: [
        .package(url: "https://github.com/SerhanAksut/DependencyKit", from: "1.4.0")
    ],
    targets: [
        .target(name: "FeatureInterface", dependencies: [
            .product(name: "FeatureStore", package: "DependencyKit")
        ])
    ]
)
