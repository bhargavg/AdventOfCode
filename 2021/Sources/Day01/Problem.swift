import Foundation
import Utilities

public func part1(input: [Int]) -> Int {
    countValleys(input: input, windowSize: 1)
}

public func part2(input: [Int]) -> Int {
    countValleys(input: input, windowSize: 3)
}

private func countValleys(input: [Int], windowSize: Int) -> Int {
    let w1 = sumsOfMovingWindows(items: input, windowSize: windowSize)
    let w2 = sumsOfMovingWindows(items: input.dropFirst(), windowSize: windowSize)

    var count = 0
    for (a, b) in zip(w1, w2) where b > a {
        count += 1
    }

    return count
}


private func sumsOfMovingWindows<T: RandomAccessCollection>(items: T, windowSize: Int) -> [Int] where T.Element == Int {
    items.movingWindows(of: windowSize).map({ $0.reduce(0, +) })
}
