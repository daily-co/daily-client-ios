// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Daily",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Daily",
            targets: [
                "Daily",
            ]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Daily",
            url: "https://daily.co/sdk/daily-ios-0.1.0-beta0.zip",
            checksum: "2d23aa23dde7ce82e485ad987c9f8591731beed5b8a67ad13212a929737bdd64"
        ),
    ]
)
