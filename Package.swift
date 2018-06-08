// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "FeedbackKit",
    products: [
        .library(
            name: "FeedbackKit",
            targets: ["FeedbackKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FeedbackKit",
            dependencies: []),
        .testTarget(
            name: "FeedbackKitTests",
            dependencies: ["FeedbackKit"]),
    ]
)
