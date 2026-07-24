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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.39.0.zip",
            checksum: "bcef1414bc3bc291bbfb26cb6c3cae7da251be0b2833ec63ca2ff0524ede1b8e"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.39.0.zip",
            checksum: "2e9fa88afa67bd43f734c0db7ff3cce0b95163aa56ec1556319fa167bddb8462"
        ),
    ]
)
