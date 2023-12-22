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
            url: "https://www.daily.co/sdk/daily-client-ios-0.14.0.zip",
            checksum: "c4c88909e244dbb2163a43fe897882ce9c1388750fd70fbb639203fd4adae2bf"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.14.0.zip",
            checksum: "fede9e34cc56091ce72b637479298846d5bb8fa83ba2b3ce54ccee7003deacd4"
        ),
    ]
)
