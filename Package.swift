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
            url: "https://www.daily.co/sdk/daily-client-ios-0.18.0.zip",
            checksum: "294850e491308a0eb35de6ba177c3a01c7d2c0a8547939df1f8835a14a202233"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.18.0.zip",
            checksum: "9e9fa0fe610eec4ea226640eee382a492f3f2ed7c5463d99681eda72b5280e17"
        ),
    ]
)
