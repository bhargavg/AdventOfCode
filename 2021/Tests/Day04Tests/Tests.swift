import XCTest
@testable import Day04

final class Day04Tests: XCTestCase {

    func testPart1Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(
            part1(boards: input.boards, callOrder: input.callOrder),
            4512
        )
    }

    func testPart2Example() throws {
        let input = try parseInput(path: "Inputs")
        XCTAssertEqual(
            part2(boards: input.boards, callOrder: input.callOrder),
            1924
        )
    }

    // MARK: - Utils
    func testParsingInput() throws {
        let (parsedBoards, callOrder) = try parseInput(path: "Inputs")
        XCTAssertEqual(callOrder, [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])

        let expectedBoards = [
            [
                [22, 13, 17, 11,  0],
                [ 8,  2, 23,  4, 24],
                [21,  9, 14, 16,  7],
                [ 6, 10,  3, 18,  5],
                [ 1, 12, 20, 15, 19],
            ],
            [
                [ 3, 15,  0,  2, 22],
                [ 9, 18, 13, 17,  5],
                [19,  8,  7, 25, 23],
                [20, 11, 10, 24,  4],
                [14, 21, 16, 12,  6],
            ],
            [
                [14, 21, 17, 24,  4],
                [10, 16, 15,  9, 19],
                [18,  8, 23, 26, 20],
                [22, 11, 13,  6,  5],
                [ 2,  0, 12,  3,  7]
            ]
        ]

        XCTAssertEqual(parsedBoards, expectedBoards)
    }

    private func parseInput(path: String) throws -> (boards: [[[Int]]], callOrder:[Int]) {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return (boards: [], callOrder: [])
        }

        let lines = contents.split(separator: "\n")

        var currentParsingIndex = 0
        let callOrder = parseCallOrder(lines: lines, currentParsingIndex: &currentParsingIndex)
        let boards = parseBoards(lines: lines, currentParsingIndex: &currentParsingIndex)

        return (boards, callOrder)
    }

    private func parseCallOrder<T: StringProtocol>(lines: [T], currentParsingIndex: inout Int) -> [Int] {
        guard lines.indices.contains(currentParsingIndex) else { return [] }

        let callOrderLine = lines[currentParsingIndex]
        currentParsingIndex += 1

        return callOrderLine.split(separator: ",").compactMap({ Int($0) })
    }

    private func parseBoards<T: StringProtocol>(lines: [T], currentParsingIndex: inout Int) -> [[[Int]]] {
        var boards = [[[Int]]]()
        while currentParsingIndex < lines.count {
            let board = parseBoard(lines: lines, currentParsingIndex: &currentParsingIndex)

            if !board.isEmpty {
                boards.append(board)
            }

        }
        return boards
    }

    private func parseBoard<T: StringProtocol>(lines: [T], currentParsingIndex: inout Int) -> [[Int]] {
        guard lines.indices.contains((currentParsingIndex + 4)) else {
            return []
        }

        var board = [[Int]]()
        for i in currentParsingIndex..<(currentParsingIndex + 5) {
            let boardLine = lines[i].split(separator: " ").compactMap({ Int($0) })

            guard boardLine.count == 5 else {
                fatalError("board line contains less than 5 elements")
            }

            board.append(boardLine)
        }

        currentParsingIndex += 5
        return board
    }
}
