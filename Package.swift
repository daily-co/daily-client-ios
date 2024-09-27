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
            url: "https://www.daily.co/sdk/daily-client-ios-0.24.0.zip",
            checksum: "2007ad80beb14e38148890d7fc1cff97324fa78a2a16b58547ec0e45b9a46066"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.24.0.zip",
            checksum: "c4503c2d9f51d6c45f28d7861d0b53c4725c4e3e66b97f40cc70a742ccb1c6da"
        ),
    ]
)
