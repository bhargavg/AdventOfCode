import Foundation

public func part1(input: (coordinates: [(x: Int, y: Int)], instructions: [FoldInstruction])) -> Int {
    guard let firstInstruction = input.instructions.first else { return 0 }

    let finalGrid = simulateFolds(coordinates: input.coordinates, instructions: [firstInstruction])

    return finalGrid.reduce(0, { (acc, row) in
        acc + row.reduce(0, { $0 + ($1 ? 1 : 0) })
    })
}

public func part2(input: (coordinates: [(x: Int, y: Int)], instructions: [FoldInstruction])) -> String {
    let finalGrid = simulateFolds(coordinates: input.coordinates, instructions: input.instructions)

    return finalGrid
        .lazy
        .map({ row in
            row.lazy.map({ $0 ? "#" : "." }).joined()
        })
        .joined(separator: "\n")
}

private func simulateFolds(coordinates: [(x: Int, y: Int)], instructions: [FoldInstruction]) -> [[Bool]] {
    var grid = makeGrid(from: coordinates)

    for instruction in instructions {
        grid = instruction.apply(on: grid)
    }

    return grid
}

private func makeGrid(from coordinates: [(x: Int, y: Int)]) -> [[Bool]] {
    guard let xMax = coordinates.lazy.map({ $0.x + 1 }).max(),
          let yMax = coordinates.lazy.map({ $0.y + 1 }).max() else {
        return []
    }

    var grid = Array(repeating: [Bool](repeating: false, count: xMax), count: yMax)

    for coordinate in coordinates {
        grid[coordinate.y][coordinate.x] = true
    }

    return grid
}

public enum FoldInstruction {
    case up(Int)
    case left(Int)

    public func apply(on grid: [[Bool]]) -> [[Bool]] {
        switch self {
        case .up(let y):
            return foldUp(grid: grid, at: y)
        case .left(let x):
            return foldLeft(grid: grid, at: x)
        }
    }

    private func foldUp(grid: [[Bool]], at foldLine: Int) -> [[Bool]] {
        let yMax = grid.count
        guard let xMax = grid.first?.count else { return [] }

        if foldLine >= yMax / 2 {
            var foldedGrid = Array(repeating: [Bool](repeating: false, count: xMax), count: foldLine)

            for y in 0..<foldLine {
                for x in 0..<xMax {
                    let yDual = foldLine + (foldLine - y)

                    foldedGrid[y][x] = (yDual < yMax)
                        ? grid[y][x] || grid[yDual][x]
                        : grid[y][x]
                }
            }

            return foldedGrid
        } else {
            var foldedGrid = Array(repeating: [Bool](repeating: false, count: xMax), count: yMax - 1 - foldLine)

            for y in stride(from: yMax - 1, to: foldLine, by: -1) {
                for x in 0..<xMax {
                    let yDual = foldLine - (y - foldLine)

                    foldedGrid[yMax - y - 1][x] = (yDual >= 0)
                        ? grid[y][x] || grid[yDual][x]
                        : grid[y][x]
                }
            }

            return foldedGrid
        }
    }

    private func foldLeft(grid: [[Bool]], at foldLine: Int) -> [[Bool]] {
        let yMax = grid.count
        guard let xMax = grid.first?.count else { return [] }

        if foldLine >= xMax / 2 {
            var foldedGrid = Array(repeating: [Bool](repeating: false, count: foldLine), count: yMax)

            for y in 0..<yMax {
                for x in 0..<foldLine {
                    let xDual = foldLine + (foldLine - x)

                    foldedGrid[y][x] = (xDual < xMax)
                        ? grid[y][x] || grid[y][xDual]
                        : grid[y][x]
                }
            }

            return foldedGrid
        } else {
            var foldedGrid = Array(repeating: [Bool](repeating: false, count: xMax - 1 - foldLine), count: xMax)

            for y in 0..<yMax {
                for x in stride(from: xMax - 1, to: foldLine, by: -1) {
                    let xDual = foldLine - (x - foldLine)

                    foldedGrid[y][xMax - x - 1] = (xDual >= 0)
                        ? grid[y][x] || grid[y][xDual]
                        : grid[y][x]
                }
            }

            return foldedGrid
        }
    }
}
