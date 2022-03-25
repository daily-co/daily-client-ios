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
    ],
    targets: [
        .binaryTarget(
            name: "Daily",
            url: "https://www.daily.co/sdk/daily-client-ios-0.1.1.zip",
            checksum: "16bc7a87a7d1ca658166bd291d9ca94ffd7700a12e8f9c59562382bbd86c8723"
        ),
    ]
)
