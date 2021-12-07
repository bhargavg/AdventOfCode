import Foundation

public func solve(input: [Int], day: Int) -> Int {
    var memo = [Int: Int]()

    let newFishesCount = input
        .lazy
        .map({ computeFishesSpawned(from: $0, day: day, memo: &memo) })
        .reduce(0, +)

    return newFishesCount + input.count
}

private func computeFishesSpawned(from startValue: Int, day: Int, memo: inout [Int: Int]) -> Int {
    if let count = memo[startValue] {
        return count
    }

    let zeroDaysOfThisFish = (0...).lazy
        .map({ (7 * $0) + startValue })
        .prefix(while: { $0 < day })

    var count = 0
    for zeroDay in zeroDaysOfThisFish {
        count += 1 + computeFishesSpawned(from: zeroDay + 9, day: day, memo: &memo)
    }

    memo[startValue] = count

    return count
}
