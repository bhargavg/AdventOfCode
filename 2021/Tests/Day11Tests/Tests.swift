import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 1656)
    }

    func testPart2Example() throws {
        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), 195)
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
