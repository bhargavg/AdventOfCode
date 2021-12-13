import Foundation

public func part1(input: [[Int]]) -> Int {
    var grid = input

    var totalFlashes = 0
    for _ in 0..<100 {
        totalFlashes += progressToNextStep(&grid)
    }

    return totalFlashes
}

public func part2(input: [[Int]]) -> Int {
    let m = input.count
    let n = input.first.map({ $0.count }) ?? 0

    var grid = input

    for stepCount in 0... {
        let flashes = progressToNextStep(&grid)

        if flashes == m * n {
            return stepCount + 1
        }
    }

    return 0
}


private func progressToNextStep(_ grid: inout [[Int]]) -> Int {
    // First, the energy level of each octopus increases by 1.
    var flashedIndices = [(i: Int, j: Int)]()
    for i in grid.indices {
        for j in grid[i].indices {
            grid[i][j] += 1
            if grid[i][j] > 9 {
                flashedIndices.append((i, j))
                grid[i][j] = -100
            }
        }
    }

    // Then, any octopus with an energy level greater than 9 flashes.
    // This increases the energy level of all adjacent octopuses by 1,
    // including octopuses that are diagonally adjacent.
    // If this causes an octopus to have an energy level greater than 9, it also flashes.
    // This process continues as long as new octopuses keep having their energy level increased beyond 9.
    // (An octopus can only flash at most once per step.)
    var thisLevel = flashedIndices
    while !thisLevel.isEmpty {
        var nextLevel = [(i: Int, j: Int)]()

        for (i, j) in thisLevel {
            for neighbor in grid.neighborsOf(i, j) {
                grid[neighbor.i][neighbor.j] += 1

                if grid[neighbor.i][neighbor.j] > 9 {
                    nextLevel.append(neighbor)
                    flashedIndices.append(neighbor)
                    grid[neighbor.i][neighbor.j] = -100
                }
            }
        }

        thisLevel = nextLevel
    }

    // Finally, any octopus that flashed during this step has its energy level set to 0, as it used all of its energy to flash.
    for (i, j) in flashedIndices {
        grid[i][j] = 0
    }

    return flashedIndices.count
}


extension Array where Element == [Int] {
    func neighborsOf(_ i: Int, _ j: Int) -> LazyFilterSequence<LazyMapSequence<LazySequence<[(Int, Int)]>.Elements, (i: Int, j: Int)>.Elements> {
        let offsets = [
            (-1, -1),
            (-1, 0),
            (-1, 1),
            (0, 1),
            (1, 1),
            (1, 0),
            (1, -1),
            (0, -1)
        ]

        return offsets
            .lazy
            .map({ (i: i + $0.0, j: j + $0.1) })
            .filter({ indices.contains($0.i) && self[$0.i].indices.contains($0.j) })
    }
}
