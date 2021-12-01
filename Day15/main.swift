import Foundation

func part1(input: [Int]) -> Int {
    guard var last = input.last else { fatalError() }

    var round = 1
    var lookup = [Int: [Int]]()
    var inputIter = input.makeIterator()

    while round <= 30000000 {
        defer { round += 1 }

        if let nextInput = inputIter.next() {
            lookup[nextInput, default: []].append(round)
            last = nextInput
            continue
        }

        if let indices = lookup[last], indices.count > 1 {
            last = indices[indices.count - 1] - indices[indices.count - 2]
        } else {
            last = 0
        }

        lookup[last, default: []].append(round)
    }

    return last
}


let input = [0,8,15,2,12,1,4]

print(part1(input: input))
