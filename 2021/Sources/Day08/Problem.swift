import Foundation

public func part1(input: [(patterns: [String], digits: [String])]) -> Int {
    input
        .lazy
        .flatMap({ signalLine in
            signalLine.digits.filter({ digit in
                digit.count == 2 || digit.count == 3 || digit.count == 4 || digit.count == 7
            })
        })
        .count
}

public func part2(input: [(patterns: [String], digits: [String])]) -> Int {
    let parser = SignalParser()
    return input.lazy.map(parser.parseDigits(from:)).reduce(0, +)
}
