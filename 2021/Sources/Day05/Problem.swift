import Foundation

public func part1(input: [(start: (x: Int, y: Int), end: (x: Int, y: Int))]) -> Int {
    solve(
        lines: input,
        markers: [
            horizontalLineMarker(line:board:),
            verticalLineMarker(line:board:)
        ]
    )
}

public func part2(input: [(start: (x: Int, y: Int), end: (x: Int, y: Int))]) -> Int {
    solve(
        lines: input,
        markers: [
            horizontalLineMarker(line:board:),
            verticalLineMarker(line:board:),
            diagonalLineMarker(line:board:)
        ]
    )
}

private func solve(
    lines: [(start: (x: Int, y: Int), end: (x: Int, y: Int))],
    markers: [(((Int, Int), (Int, Int)), inout [[Int]]) -> Bool]
) -> Int {
    // Assumption: There won't be any number more than 999
    var board = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

    for line in lines {
        for marker in markers {
            guard !marker(line, &board) else { break }
        }
    }

    return board.reduce(0, { (acc, row) in
        acc + row.lazy.filter({ $0 > 1 }).count
    })
}

private func horizontalLineMarker(
    line: (start: (x: Int, y: Int), end: (x: Int, y: Int)),
    board: inout [[Int]]
) -> Bool {
    guard line.start.y == line.end.y else { return false }

    for j in stride(from: min(line.start.x, line.end.x), through: max(line.start.x, line.end.x), by: 1) {
        board[line.start.y][j] += 1
    }

    return true
}

private func verticalLineMarker(
    line: (start: (x: Int, y: Int), end: (x: Int, y: Int)),
    board: inout [[Int]]
) -> Bool {
    guard line.start.x == line.end.x else { return false }

    for i in stride(from: min(line.start.y, line.end.y), through: max(line.start.y, line.end.y), by: 1) {
        board[i][line.start.x] += 1
    }

    return true
}

private func diagonalLineMarker(
    line: (start: (x: Int, y: Int), end: (x: Int, y: Int)),
    board: inout [[Int]]
) -> Bool {
    guard abs(line.start.x - line.end.x) == abs(line.start.y - line.end.y) else { return false }

    let indicesSeq = zip(
        stride(from: line.start.x, through: line.end.x, by: line.start.x > line.end.x ? -1 : 1),
        stride(from: line.start.y, through: line.end.y, by: line.start.y > line.end.y ? -1 : 1)
    )

    for (i, j) in indicesSeq {
        board[j][i] += 1
    }

    return true
}
