// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Daily",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Daily",
            targets: [
                "Daily"
            ]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Daily",
            url: "https://www.daily.co/sdk/daily-client-ios-0.11.1.zip",
            checksum: "9c2d55f5ceb9a1dae9ce25e3af751f2deeae473fde4cd7dd319c3be660515ba6"
        ),
    ]
)
