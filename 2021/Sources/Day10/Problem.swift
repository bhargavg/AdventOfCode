import Foundation

public func part1(input: [[Character]]) -> Int {
    let errorScores: [Character: Int] = [
        ")" : 3,
        "]" : 57,
        "}" : 1197,
        ">" : 25137,
    ]

    return input
        .lazy
        .map(parseSyntaxErrorScore(of:))
        .compactMap({
            guard case .corrupted(let firstMisMatch) = $0,
                  let score = errorScores[firstMisMatch] else {
                return nil
            }
            return score
        })
        .reduce(0, +)
}

public func part2(input: [[Character]]) -> Int {
    let pendingScores: [Character: Int] = [
        "(": 1,
        "[": 2,
        "{": 3,
        "<": 4,
    ]
    
    let scores: [Int] = input
        .lazy
        .map(parseSyntaxErrorScore(of:))
        .compactMap({
            guard case .incomplete(let pending) = $0 else {
                return nil
            }

            let value = pending.reversed().reduce(0, { $0 * 5 + pendingScores[$1, default: 0] })
            print(pending, value)
            return value
        })
        .sorted()

    return scores[scores.count / 2]
}

private func parseSyntaxErrorScore(of input: [Character]) -> SyntaxStatus {
    var stack = [Character]()

    for char in input {
        switch char {
        case "(", "[", "{", "<":
            stack.append(char)
        case ")":
            guard stack.popLast() == "(" else {
                return .corrupted(firstMisMatch: char)
            }
        case "]":
            guard stack.popLast() == "[" else {
                return .corrupted(firstMisMatch: char)
            }
        case "}":
            guard stack.popLast() == "{" else {
                return .corrupted(firstMisMatch: char)
            }
        case ">":
            guard stack.popLast() == "<" else {
                return .corrupted(firstMisMatch: char)
            }
        default:
            fatalError("Invalid character")
        }
    }

    return stack.isEmpty ? .correct : .incomplete(openPending: stack)
}

private enum SyntaxStatus {
    case correct
    case corrupted(firstMisMatch: Character)
    case incomplete(openPending: [Character])
}
