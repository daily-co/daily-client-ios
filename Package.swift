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
            url: "https://www.daily.co/sdk/daily-client-ios-0.19.0.zip",
            checksum: "88d5addd40061bb553d63d3b95504eaa7a61f3708b53a98be601ab3c4bfc4ce6"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.19.0.zip",
            checksum: "be0e527a1fc3f9ff60ee5b91024268e1c1bd18febbd8b028ca8587890ebc2aa7"
        ),
    ]
)
