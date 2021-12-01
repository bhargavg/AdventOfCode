import XCTest
@testable import Utilities

final class UtilitiesTests: XCTestCase {
    func testWindowSizeOfZero() {
        let arr = [1,2,3,4,5]
        XCTAssertEqual(arr.movingWindows(of: 0), [])
    }

    func testWindowSizeOfOne() {
        let arr = [1,2,3,4,5]
        XCTAssertEqual(arr.movingWindows(of: 1), [[1], [2], [3], [4], [5]])
    }

    func testWindowSizeOfThree() {
        let arr = [1,2,3,4,5]
        XCTAssertEqual(arr.movingWindows(of: 2), [[1,2], [2,3], [3,4], [4,5]])
    }

    func testWindowSizeOfMoreThanInput() {
        let arr = [1,2,3,4,5]
        XCTAssertEqual(arr.movingWindows(of: 20), [])
    }
}
