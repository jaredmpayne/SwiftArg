// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftArg",
    products: [
        .library(name: "SwiftArg", targets: ["SwiftArg"])
    ],
    targets: [
        .target(name: "SwiftArg", dependencies: []),
        .testTarget(name: "SwiftArgTests", dependencies: ["SwiftArg"])
    ]
)
