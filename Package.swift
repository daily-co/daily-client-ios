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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.38.0.zip",
            checksum: "8475da600254cc74b17d67b9bbe2c6e00aa0444098ce14df9ff5c09b190929ca"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.38.0.zip",
            checksum: "2ab1c4a3c6ed4c71a729709f654cfd327cf61bf47c46191144c5beeb244bd521"
        ),
    ]
)
