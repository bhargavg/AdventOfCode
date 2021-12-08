import Foundation

func part1(input: [Int]) -> Int {
    solve(input: input, costFunction: { (from, to) in
        return abs(from - to)
    })
}

func part2(input: [Int]) -> Int {
    solve(input: input, costFunction: { (from, to) in
        let distance = abs(from - to)
        return distance * (distance + 1) / 2
    })
}

private func solve(input: [Int], costFunction: (Int, Int) -> Int) -> Int {
    guard let start = input.min(),
          let end = input.max() else { return 0 }

    var freq = [Int: Int]()
    for num in input {
        freq[num, default: 0] += 1
    }

    var minCost =  Int.max
    for possiblePosition in stride(from: start, through: end, by: 1) {
        var cost = 0
        for (position, freq) in freq {
            cost += costFunction(possiblePosition, position) * freq
        }

        minCost = min(minCost, cost)
    }

    return minCost
}
