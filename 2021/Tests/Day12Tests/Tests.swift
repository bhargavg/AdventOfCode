import XCTest
@testable import Day12

final class Day12Tests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 10)
    }

    func testPart2Example() throws {
        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), 36)
    }

    // MARK: - Utils
    func testParsing() throws {
        let parsed = try parseInput(path: "Inputs")
        let expected = [
            "start": Set(["A", "b"]),
            "A": Set(["c", "b", "end", "start"]),
            "b": Set(["A", "d", "start", "end"]),
            "d": Set(["b"]),
            "c": Set(["A"]),
            "end": Set(["A", "b"])
        ]

        XCTAssertEqual(parsed, expected)
    }

    private func parseInput(path: String) throws -> [String: Set<String>]  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return [:]
        }

        let edges = contents
            .split(separator: "\n")
            .compactMap(parse(line:))

        var edgesMap = [String: Set<String>]()
        for edge in edges {
            edgesMap[edge.from, default: Set()].insert(edge.to)
            edgesMap[edge.to, default: Set()].insert(edge.from)
        }

        return edgesMap
    }

    private func parse<T: StringProtocol>(line: T) -> (from: String, to: String)? {
        let comps = line.split(separator: "-")

        return (comps.count == 2)
            ? (from: String(comps[0]), to: String(comps[1]))
            : nil
    }
}
