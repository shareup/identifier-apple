// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(
            name: "Identifier",
            targets: ["Identifier"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/shareup/base64url-apple.git",
            from: "1.0.0"),
        .package(
            url: "https://github.com/shareup/bytes-apple.git",
            from: "3.1.0"),
    ],
    targets: [
        .target(
            name: "Identifier",
            dependencies: [
                .product(name: "Base64URL", package: "base64url-apple"),
                .product(name: "Bytes", package: "bytes-apple"),
            ]),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]),
    ]
)
