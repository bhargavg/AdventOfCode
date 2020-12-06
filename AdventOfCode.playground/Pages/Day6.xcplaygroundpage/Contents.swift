import Foundation

func part1(answers: [String]) -> Int {
    joinGroupAnswers(input: answers)
        .lazy
        .map(unionCharacterSet(in:))
        .map(\.count )
        .reduce(0, +)
}

func part2(answers: [String]) -> Int {
    joinGroupAnswers(input: answers)
        .lazy
        .map(intersectionCharacterSet(in:))
        .map(\.count)
        .reduce(0, +)
}

func joinGroupAnswers(input: [String]) -> [[String]] {
    input.reduce(into: [[String]](), { (acc, next) in
        if next == "" {
            acc.append([])
            return
        }

        if acc.isEmpty {
            acc.append([])
        }

        acc[acc.count - 1].append(next)
    })
}

func unionCharacterSet(in group: [String]) -> Set<Character> {
    group
        .lazy
        .map(Set.init(_:))
        .reduce(into: Set<Character>(), { (acc, next) in
            acc.formUnion(next)
        })
}

func intersectionCharacterSet(in group: [String]) -> Set<Character> {
    let sets = group
        .lazy
        .map(Set.init(_:))

    guard let first = sets.first else { return .init() }

    return sets
        .dropFirst()
        .reduce(into: first, { (acc, next) in
            acc.formIntersection(next)
        })
}

let input = Bundle.main.loadLines(from: "Day6")

assert(part1(answers: input) == 6310)
assert(part2(answers: input) == 3193)

