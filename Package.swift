// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyKit",
    products: [
        .library(
            name: "DependencyKit",
            targets: ["DependencyKit"]),
    ],
    targets: [
        .target(name: "DependencyKit"),
        .testTarget(name: "DependencyKitTests", dependencies: ["DependencyKit"]),
    ]
)
