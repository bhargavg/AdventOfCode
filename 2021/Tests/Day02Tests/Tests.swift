import XCTest
@testable import Day02

final class Day02Tests: XCTestCase {
    func testPart1Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part1(input: input), 150)
    }

    func testPart2Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part2(input: input), 900)
    }

    private func parseInput(path: String) throws -> [(String, Int)] {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return  []
        }

        return Array(
            contents
                .lazy
                .split(separator: "\n")
                .map({ $0.split(separator: " ") })
                .compactMap({ comps in
                    guard let direction = comps.first.map(String.init(_:)),
                          let offset = comps.last.flatMap({ Int(String($0)) }) else {
                        return nil
                    }

                    return (direction, offset)
                })
        )
    }
}
