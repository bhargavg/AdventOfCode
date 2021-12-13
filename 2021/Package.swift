// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [],
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
        .target(
            name: "Day05",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day05Tests",
            dependencies: ["Day05"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day06",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day06Tests",
            dependencies: ["Day06"]),
        .target(
            name: "Day07",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day07Tests",
            dependencies: ["Day07"]),
        .target(
            name: "Day08",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day08Tests",
            dependencies: ["Day08"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day09",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day09Tests",
            dependencies: ["Day09"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day10",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day10Tests",
            dependencies: ["Day10"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day11",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day11Tests",
            dependencies: ["Day11"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day12",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day12Tests",
            dependencies: ["Day12"],
            resources: [.copy("Inputs.txt")]),
        .target(
            name: "Day13",
            dependencies: ["Utilities"],
            exclude: ["README.md"]),
        .testTarget(
            name: "Day13Tests",
            dependencies: ["Day13"],
            resources: [.copy("Inputs.txt")]),

    ]
)
