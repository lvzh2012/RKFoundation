// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RKFoundation",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RKFoundation",
            targets: ["RKFoundation"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "RKFoundation",
            path: "RKFoundation.xcframework"
        ),
    ]
)

