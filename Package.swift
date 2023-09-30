// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyKit",
    products: [
        .library(name: "FeatureStore", targets: ["FeatureStore"]),
    ],
    targets: [
        .target(name: "FeatureStore"),
        .testTarget(name: "FeatureStoreTests", dependencies: ["FeatureStore"]),
    ]
)
