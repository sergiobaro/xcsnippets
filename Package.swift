// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcsnippets",
    products: [
        .executable(name: "xcsnippets", targets: ["xcsnippets"]),
        .library(name: "XCSnippetsLib", targets: ["XCSnippetsLib"])
    ],
    targets: [
        .target(
            name: "xcsnippets",
            dependencies: ["XCSnippetsLib"]
            ),
        .target(
            name: "XCSnippetsLib"
        ),
        .testTarget(
            name: "XCSnippetsLibTests",
            dependencies: ["XCSnippetsLib"]
        ),
    ]
)