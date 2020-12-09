import Foundation

func part1(input: [Int]) -> Int {
    let windowSize = 25

    guard input.count >= (windowSize + 1) else {
        fatalError("Wrong input size")
    }

    // Freq map
    var window = [Int: Int]()
    for i in 0..<windowSize {
        window[input[i], default: 0] += 1
    }

    for i in stride(from: input.startIndex, to: input.endIndex - (windowSize + 1), by: 1) {
        let target = input[i + windowSize]

        if !window.contains(where: { window[target - $0.key] != nil }) {
            return target
        }

        // Move both ends of the window
        let newCount = window[input[i], default: 1] - 1
        window[input[i]] = (newCount == 0) ? nil : newCount
        window[target, default: 0] += 1
    }

    fatalError("All input nums satisfies the sum condition")
}

func part2(input: [Int], target: Int) -> Int {
    guard let range = findContinousRange(in: input, withSum: target), !range.isEmpty else {
        fatalError("Couldn't find range")
    }

    return (input[range].max() ?? 0) + (input[range].min() ?? 0)
}

func findContinousRange(in input: [Int], withSum target: Int) -> ClosedRange<Int>? {
    guard !input.isEmpty else { return nil }

    var windowSum = input[input.startIndex]

    var i = input.startIndex
    var j = i

    while i <= j && j < input.endIndex {
        while j < input.endIndex && windowSum < target {
            input.formIndex(after: &j)
            windowSum += input[j]
        }

        while i < j && windowSum > target {
            windowSum -= input[i]
            input.formIndex(after: &i)
        }

        if windowSum == target {
            return i...j
        }
    }

    return nil
}

let input = Bundle
    .main
    .loadNums(from: "Day9")

assert(part1(input: input) == 258585477)
assert(part2(input: input, target: 258585477) == 36981213)
