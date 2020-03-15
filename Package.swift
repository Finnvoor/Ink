// swift-tools-version:5.1

/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "InkView",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "InkView", targets: ["InkView"]),
    ],
    targets: [
        .target(name: "InkView"),
        .testTarget(name: "InkViewTests", dependencies: ["InkView"])
    ]
)
