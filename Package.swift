// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(
            name: "Identifier",
            targets: ["Identifier"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/shareup/base64url-apple.git",
            from: "1.0.0"
        ),
    ],
    targets: [
        .target(
            name: "Identifier",
            dependencies: [
                .product(name: "Base64URL", package: "base64url-apple"),
            ]
        ),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]
        ),
    ]
)
