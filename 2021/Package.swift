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
        .library(
            name: "Day02",
            targets: ["Day02"]),
        .library(
            name: "Day03",
            targets: ["Day03"]),
        .library(
            name: "Day04",
            targets: ["Day04"]),
    ],
    targets: [
        .target(
            name: "Utilities"),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]),
        .target(
            name: "Day01",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day01Tests",
            dependencies: ["Day01"]),
        .target(
            name: "Day02",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day02Tests",
            dependencies: ["Day02"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day03",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day03Tests",
            dependencies: ["Day03"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day04",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day04Tests",
            dependencies: ["Day04"],
            resources: [.copy("Inputs.txt")]),
    ]
)
