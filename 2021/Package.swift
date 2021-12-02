// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [
        .library(
            name: "Utilities",
            targets: ["Utilities"]),
        .library(
            name: "Day01",
            targets: ["Day01"]),
    ],
    targets: [
        .target(
            name: "Day01",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day01Tests",
            dependencies: ["Day01"]),
        .target(
            name: "Utilities"),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]),
    ]
)
