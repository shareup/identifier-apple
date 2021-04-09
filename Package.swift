// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(
            name: "Identifier",
            targets: ["Identifier"]),
        .library(
            name: "IdentifierDynamic",
            type: .dynamic,
            targets: ["Identifier"]),
    ],
    dependencies: [
        .package(name: "Bytes", url: "https://github.com/shareup/bytes-apple.git", from: "2.1.0")
    ],
    targets: [
        .target(
            name: "Identifier",
            dependencies: [.product(name: "BytesDynamic", package: "Bytes")]),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]),
    ]
)
