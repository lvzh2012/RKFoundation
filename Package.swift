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
            url: "https://github.com/your-username/RKFoundation/releases/download/1.0.0/RKFoundation.xcframework.zip",
            checksum: "48db0bfc2b0afef21335e35ff17c8cad6a379ec4776bbec0127ceb0b9e5bc770"
        ),
    ]
)

