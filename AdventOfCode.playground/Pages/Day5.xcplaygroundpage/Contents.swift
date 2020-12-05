import Foundation

func part1(ids: [Int]) -> Int? {
    ids.max()
}

func part2(ids: [Int]) -> Int {
    let sortedIDs = ids.sorted()

    return zip(
        sortedIDs,
        sortedIDs.dropFirst()
    ).first(where: { $0.1 - $0.0 == 2 })
     .map({ $0.0 + 1 })!
}

func bisect<S: Sequence>(range: ClosedRange<Int>, using ops: S) -> Int where S.Element == Character {
    var from = range.lowerBound
    var to = range.upperBound

    var mid = 0

    for char in ops {
        mid = from + (to - from) / 2

        switch char {
        case "F", "L":
            to = mid
        case "B", "R":
            from = mid
        default:
            fatalError("Unknown char: \(char)")
        }
    }

    return to
}

func computeSeatID(ops: String) -> Int {
    let rowOps = ops.dropLast(3)
    let colOps = ops.dropFirst(7)

    let row = bisect(range: 0...127, using: rowOps)
    let col = bisect(range: 0...7, using: colOps)

    let result = (row * 8) + col

    return result
}


let input = Bundle
    .main
    .loadLines(from: "Day5")
    .map(computeSeatID(ops:))

assert(part1(ids: input) == 828)
assert(part2(ids: input) == 565)
