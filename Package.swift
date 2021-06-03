// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(
            name: "Identifier",
            targets: ["Identifier"]),
    ],
    dependencies: [
        .package(name: "Bytes", url: "https://github.com/shareup/bytes-apple.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Identifier",
            dependencies: ["Bytes"]),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]),
    ]
)
