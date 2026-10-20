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
            url: "https://sdk-downloads.daily.co/daily-client-ios-0.41.0.zip",
            checksum: "df14d1f113ae88e3dc78f286a6f843e231c911a3eb326b2e976331781561360b"
        ),
        .binaryTarget(
            name: "DailySystemBroadcast",
            url: "https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.41.0.zip",
            checksum: "c80d26767696072e5915ff4df1f2b194f8157df3287ecc9ecfd94706a75b2131"
        ),
    ]
)
