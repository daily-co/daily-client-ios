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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.34.0.zip",
            checksum: "141bbe7f1b64ccb55cdcbf30ed80f071dd307c686e71c4520e7ea62d1a3b7404"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.34.0.zip",
            checksum: "abf6eaeb0ab30f71d22098d144d2e07fbd5a66bf8c6c970645b8fe6983fd53bc"
        ),
    ]
)
