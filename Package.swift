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
            url: "https://www.daily.co/sdk/daily-client-ios-0.30.0.zip",
            checksum: "275a3a79506baca95110bb6e73c9b622ec0b7cedd32e8a15334fd7e8330df709"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.30.0.zip",
            checksum: "74186e6120c414608f3884c997a7bf61ae9a9e1e7ab2dcfc840ac571eeaa8fdd"
        ),
    ]
)
