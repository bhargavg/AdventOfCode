import XCTest
@testable import Day10

final class Day10Tests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 26397)
    }

    func testPart2Example() throws {
        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), 288957)
    }


    // MARK: - Utils
    private func parseInput(path: String) throws -> [[Character]]  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return []
        }

        return contents.split(separator: "\n").map(Array.init(_:))
    }
}
