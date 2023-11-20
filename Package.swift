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
            url: "https://www.daily.co/sdk/daily-client-ios-0.12.0.zip",
            checksum: "2135eb9ab83b64e036877aa3b5cc4f3a1697a890883fd079dd2972b17a565a85"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.12.0.zip",
            checksum: "1f0e9c6143280d6f27b4ba5d5800237011361d77164f1545cf9853f409108837"
        ),
    ]
)
