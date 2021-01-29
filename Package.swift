// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(
            name: "Identifier",
            targets: ["Identifier"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Identifier",
            dependencies: []),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]),
    ]
)
