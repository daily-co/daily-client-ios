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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.32.0.zip",
            checksum: "341e16e475de016c7f9453777dc9f4ecba140a7d250f6d38dd91e4e348430a31"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.32.0.zip",
            checksum: "5448e17d5841213ab5dc9043768cac851a358d297848c7b47037414b0b5ac822"
        ),
    ]
)
