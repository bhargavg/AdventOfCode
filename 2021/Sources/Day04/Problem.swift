import Foundation

public func part1(boards: [[[Int]]], callOrder: [Int]) -> Int {
    return play(boards: boards, callOrder: callOrder, shouldEndGame: { boardsYetToWinCount in
        boardsYetToWinCount < boards.count
    })
}

public func part2(boards: [[[Int]]], callOrder: [Int]) -> Int {
    return play(boards: boards, callOrder: callOrder, shouldEndGame: { boardsYetToWinCount in
        boardsYetToWinCount == 0
    })
}

private func play(boards: [[[Int]]], callOrder: [Int], shouldEndGame: (Int) -> Bool) -> Int {
    guard let boardDimension = boards.first?.count else {
        return -1
    }

    // lookup table to get board indices to which a number belongs to
    var numberToBoardIndex = [Int: [Int]]()

    // lookup table to mark which number exists at what position in each board.
    // Assumption: Numbers will always be in the range of 0..<100
    var boardNumPositions = Array(
        repeating: Array(repeating: Optional<(row: Int, col: Int)>.none, count: 100),
        count: boards.count
    )

    // board wise counters to keep track how many rows & cols are still pending.
    // Assumption: A board is even sized (ie., rows == cols).
    var pendingCounts = Array(
        repeating: (
            rowCounts: Array(repeating: boardDimension, count: boardDimension),
            colCounts: Array(repeating: boardDimension, count: boardDimension)
        ),
        count: boards.count
    )

    // Populate lookup tables
    for (boardIndex, board) in boards.enumerated() {
        for (rowIndex, row) in board.enumerated() {
            for (colIndex, num) in row.enumerated() {
                numberToBoardIndex[num, default: []].append(boardIndex)
                boardNumPositions[boardIndex][num] = (rowIndex, colIndex)
            }
        }
    }

    var boardsYetToWin = Set(boards.indices)

    // Begin calling out numbers in given order
    for num in callOrder {
        guard let boardIndices = numberToBoardIndex[num] else {
            fatalError("\(num) not found in any boards")
        }

        for boardIndex in boardIndices {
            guard let (row, col) = boardNumPositions[boardIndex][num] else {
                fatalError("We should be getting row & col for this")
            }

            pendingCounts[boardIndex].rowCounts[row] -= 1
            pendingCounts[boardIndex].colCounts[col] -= 1
            boardNumPositions[boardIndex][num] = nil

            if pendingCounts[boardIndex].rowCounts[row] == 0 || pendingCounts[boardIndex].colCounts[col] == 0 {
                boardsYetToWin.remove(boardIndex)
            }

            if shouldEndGame(boardsYetToWin.count) {
                let sumOfUnMarkedNums = boardNumPositions[boardIndex].lazy
                    .enumerated()
                    .filter({ $0.element != nil })
                    .map({ $0.offset })
                    .reduce(0, +)

                return num * sumOfUnMarkedNums
            }
        }
    }

    return -1
}
