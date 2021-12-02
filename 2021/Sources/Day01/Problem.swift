import Foundation
import Utilities

public func part1(input: [Int]) -> Int {
    return zip(input, input.dropFirst())
        .lazy
        .map({ ($0.0 < $0.1) ? 1 : 0 })
        .reduce(0, +)
}

public func part2(input: [Int]) -> Int {
    return zip(input, input.dropFirst(3))
        .lazy
        .map({ ($0.0 < $0.1) ? 1 : 0 })
        .reduce(0, +)
}
