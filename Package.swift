// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "app",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.5.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.2.2"),
//        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0-rc.1.2"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver", from: "2.0.0-rc"),
        .package(url: "https://github.com/binarybirds/liquid.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver.git", from: "1.0.0"),
//        .package(url: "https://github.com/binarybirds/liquid-aws-s3-driver.git", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/spec.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
//            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Liquid", package: "liquid"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
//            .product(name: "LiquidAwsS3Driver", package: "liquid-aws-s3-driver"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "App"),
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "Spec", package: "spec"),
        ])
    ]
)

