import Foundation

public func part1(input: [[Int]]) -> Int {
    let lowPoints = getLowPoints(in: input)

    let lowPointsSum = lowPoints
        .lazy
        .map({ input[$0.i][$0.j] })
        .reduce(0, +)

    return lowPointsSum + lowPoints.count
}

public func part2(input: [[Int]]) -> Int {
    var grid = input

    var sizes = [Int]()
    for (i, j) in getLowPoints(in: grid) {
        let size = dfs(&grid, i, j)
        sizes.append(size)
    }

    return sizes.sorted().suffix(3).reduce(1, *)
}

private func getLowPoints(in grid: [[Int]]) -> [(i: Int, j: Int)] {
    var lowPoints = [(i: Int, j: Int)]()

    for i in grid.indices {
        for j in grid[i].indices {
            guard grid.neighborsOf(i, j).allSatisfy({ grid[i][j] < grid[$0.0][$0.1] }) else { continue }
            lowPoints.append((i, j))
        }
    }

    return lowPoints
}

private func dfs(_ grid: inout [[Int]], _ i: Int, _ j: Int) -> Int {
    guard grid.indices.contains(i), grid[i].indices.contains(j), grid[i][j] < 9 else { return 0 }

    var size = 0

    // Using `9` as sential value to mark this cell as visited.
    let value = grid[i][j]
    grid[i][j] = 9

    for (ii, jj) in grid.neighborsOf(i, j) where grid[ii][jj] > value {
        size += dfs(&grid, ii, jj)
    }

    return 1 + size
}

private extension Array where Element == [Int] {
    func neighborsOf(_ i: Int, _ j: Int) -> [(Int, Int)] {
        let offsets = [
            (i: 0, j: 1),
            (i: 0, j: -1),
            (i: 1, j: 0),
            (i: -1, j: 0),
        ]

        return offsets
            .compactMap({ offset in
                guard indices.contains(i + offset.i), self[i + offset.i].indices.contains(j + offset.j) else {
                    return nil
                }

                return (i + offset.i, j + offset.j)
            })
    }
}
