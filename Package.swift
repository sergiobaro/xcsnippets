// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "xcsnippets",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .executable(name: "xcsnippets", targets: ["xcsnippets"]),
    .library(name: "XCSnippetsLib", targets: ["XCSnippetsLib"])
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.0")),
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
      dependencies: ["XCSnippetsLib", "Nimble"]
    ),
  ]
)
