// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    products: [
        .library(name: "FirstFeature", targets: ["FirstFeature"]),
        .library(name: "SecondFeature", targets: ["SecondFeature"])
    ],
    dependencies: [
        .package(path: "Packages")
    ],
    targets: [
        .target(name: "FirstFeature", dependencies: [
            .product(name: "FeatureInterface", package: "Packages")
        ]),
        .target(name: "SecondFeature", dependencies: [
            .product(name: "FeatureInterface", package: "Packages")
        ])
    ]
)
