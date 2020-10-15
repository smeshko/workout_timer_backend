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
        .package(url: "https://github.com/vapor/vapor.git", from: "4.5.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.2.2"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver", from: "2.0.0-rc"),
        .package(name: "AWSSDKSwift", url: "https://github.com/soto-project/soto.git", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/spec.git", from: "1.0.0"),
        .package(url: "https://github.com/smeshko/workout-timer-api.git", from: "1.1.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "S3", package: "AWSSDKSwift"),
            .product(name: "SES", package: "AWSSDKSwift"),
            .product(name: "IAM", package: "AWSSDKSwift"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "WorkoutTimerAPI", package: "workout-timer-api")
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

