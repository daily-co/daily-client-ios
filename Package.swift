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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.33.0.zip",
            checksum: "1dd0ec3261ff9ae5c79a6df75b3e55eec6afd7ffc964c126f971e56e96329f89"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.33.0.zip",
            checksum: "2c1ff7890645bde347a1a81ff11b21a1800e593a4da1d96a8219fd043edf18c7"
        ),
    ]
)
