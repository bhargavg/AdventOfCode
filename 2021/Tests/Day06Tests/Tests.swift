import XCTest
@testable import Day06

final class Day06Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(solve(input: exampleInput, day: 80), 5934)
    }

    func testPart2Example() {
        XCTAssertEqual(solve(input: exampleInput, day: 256), 26984457539)
    }
}
