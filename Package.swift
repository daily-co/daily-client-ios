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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.35.0.zip",
            checksum: "db206b1cb1f94863dac8615278fd027e16f502c4eaaa5db1c62633ea5d193477"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.35.0.zip",
            checksum: "20c32a5e8bd3693933ffbc9fa0dea52ef2609a77de3fbede34b43cf711c0a808"
        ),
    ]
)
