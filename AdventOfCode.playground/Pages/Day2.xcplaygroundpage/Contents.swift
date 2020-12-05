import Foundation


func part1(text: String) -> Int {
    return text.split(separator: "\n")
        .lazy
        .filter(isCountValid(line:))
        .count
}

func part2(text: String) -> Int {
    return text.split(separator: "\n")
        .lazy
        .filter(isOccurancesValid(line:))
        .count
}

func isCountValid(line: String.SubSequence) -> Bool {
    let (range, character, password) = parse(line: line)

    let count = password
        .lazy
        .filter({ $0 == character })
        .count

    return range.contains(count)
}

func isOccurancesValid(line: String.SubSequence) -> Bool {
    let (range, character, password) = parse(line: line)

    let passChars = Array(password)

    return (passChars[range.lowerBound - 1] == character && passChars[range.upperBound - 1] != character)
        || (passChars[range.lowerBound - 1] != character && passChars[range.upperBound - 1] == character)
}

func parse(line: String.SubSequence) -> (ClosedRange<Int>, Character, String.SubSequence) {
    let comps = line.split(separator: " ")

    let rangeNums = comps[0]
        .split(separator: "-")
        .compactMap({ Int($0) })

    let character = comps[1].first!
    let password  = comps[2]

    return (rangeNums[0]...rangeNums[1], character, password)
}


let input = Bundle.main.loadText(from: "Day2")!
assert(part1(text: input) == 638)
assert(part2(text: input) == 699)
