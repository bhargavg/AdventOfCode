import XCTest
@testable import Day05

final class Day05Tests: XCTestCase {
    func testPart1Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part1(input: input), 5)
    }

    func testPart2Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(part2(input: input), 12)
    }

    func testParser() throws {
        let parsedCoordinates = try parseInput(path: "Inputs")
        let expectedCoordinates = [
            (start: (x: 0, y: 9), end: (x: 5, y: 9)),
            (start: (x: 8, y: 0), end: (x: 0, y: 8)),
            (start: (x: 9, y: 4), end: (x: 3, y: 4)),
            (start: (x: 2, y: 2), end: (x: 2, y: 1)),
            (start: (x: 7, y: 0), end: (x: 7, y: 4)),
            (start: (x: 6, y: 4), end: (x: 2, y: 0)),
            (start: (x: 0, y: 9), end: (x: 2, y: 9)),
            (start: (x: 3, y: 4), end: (x: 1, y: 4)),
            (start: (x: 0, y: 0), end: (x: 8, y: 8)),
            (start: (x: 5, y: 5), end: (x: 8, y: 2)),
        ]

        XCTAssertEqual(parsedCoordinates.count, expectedCoordinates.count)

        for (parsed, expected) in zip(parsedCoordinates, expectedCoordinates) {
            XCTAssertEqual(parsed.start.x, expected.start.x)
            XCTAssertEqual(parsed.start.y, expected.start.y)
            XCTAssertEqual(parsed.end.x, expected.end.x)
            XCTAssertEqual(parsed.end.y, expected.end.y)
        }
    }

    private func parseInput(path: String) throws -> [(start: (x: Int, y: Int), end: (x: Int, y: Int))]  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return []
        }

        return contents.split(separator: "\n").compactMap(parseCoordinates(in:))
    }

    private func parseCoordinates<T: StringProtocol>(in line: T) -> ((x1: Int, y1: Int), (x2: Int, y2: Int))? {
        guard !line.isEmpty else { return nil }

        var i = line.startIndex
        var startIndex: String.Index? = nil
        var output = [Int]()

        while true {
            if line.indices.contains(i) && ("0"..."9").contains(line[i]) {
                if startIndex == nil {
                    startIndex = i
                }
            } else {
                if let sIndex = startIndex {
                    guard let num = Int(line[sIndex..<i]) else {
                        fatalError("Unable to parse: \(line[sIndex..<i])")
                    }
                    startIndex = nil
                    output.append(num)
                }
            }

            guard let ii = line.index(i, offsetBy: 1, limitedBy: line.endIndex) else {
                break
            }
            i = ii
        }

        guard output.count == 4 else { return nil }

        return ((output[0], output[1]), (output[2], output[3]))
    }
}
