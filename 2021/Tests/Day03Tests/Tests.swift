import XCTest
@testable import Day03

final class Day03Tests: XCTestCase {
    func testPart1Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part1(input: input), 198)
    }

    func testPart2Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part2(input: input), 230)
    }

    private func parseInput(path: String) throws -> [[Character]] {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return  []
        }

        return contents.split(separator: "\n").map(Array.init(_:))
    }
}
