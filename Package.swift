// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "UI",
            targets: ["UI"]
        )
    ],
    targets: [
        .target(
            name: "UI"
        )
    ]
)
