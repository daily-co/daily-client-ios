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
        .library(
            name: "DailySystemBroadcast",
            targets: [
                "DailySystemBroadcast"
            ]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Daily",
            url: "https://www.daily.co/sdk/daily-client-ios-0.31.0.zip",
            checksum: "6679ea815d5f4d0b1c1d9c21c1092d5c1d548abc43a377c1d3fe4b68bc51fb49"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.31.0.zip",
            checksum: "6d7667cd412a05c387789eb772cbeb4d713d0973bd3198efaf5f58c18444665f"
        ),
    ]
)
