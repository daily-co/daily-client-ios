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
            url: "https://www.daily.co/sdk/daily-client-ios-0.25.0.zip",
            checksum: "c97138d8eabd737159fdb4469e876d2fbbf2680b2e7a8b6bb20eee5f4f979f2f"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.25.0.zip",
            checksum: "91e206225a0451c6c4f81f5cbe907355a2c16383c99f2b72aae55df0e54c031c"
        ),
    ]
)
