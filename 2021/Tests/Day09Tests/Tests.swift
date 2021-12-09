import XCTest
@testable import Day09

final class Day09Tests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 15)
    }

    func testPart2Example() throws {
        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), 1134)
    }

    func testParser() throws {
        let parsed = try parseInput(path: "Inputs")
        let expected = [
            [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
            [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
            [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
            [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
            [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
        ]

        XCTAssertEqual(parsed, expected)
    }

    // MARK: - Utils
    private func parseInput(path: String) throws -> [[Int]]  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return []
        }

        return contents.split(separator: "\n").compactMap(parse(line:))
    }

    private func parse<T: StringProtocol>(line: T) -> [Int] {
        line.compactMap(\.asciiValue).map({ Int($0 - 48) })
    }
}
