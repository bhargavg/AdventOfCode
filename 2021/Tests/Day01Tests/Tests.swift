import XCTest
@testable import Day01

final class Day01Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(part1(input: exampleInput), 7)
    }

    func testPart1() {
        XCTAssertEqual(part1(input: puzzleInput), 1602)
    }

    func testPart2Example() {
        XCTAssertEqual(part2(input: exampleInput), 5)
    }

    func testPart2() {
        XCTAssertEqual(part2(input: puzzleInput), 1633)
    }
}
