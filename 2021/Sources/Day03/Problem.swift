import Foundation


func part1(input: [[Character]]) -> Int {
    guard let n = input.first?.count else { return 0 }

    var gain = 0
    var epsilon = 0

    for j in 0..<n {
        let msb = mostSignificantBit(bitIndex: j, input: input)
        let lsb = 1 - msb

        gain = (gain << 1) | msb
        epsilon = (epsilon << 1) | lsb
    }

    return gain * epsilon
}

func part2(input: [[Character]]) -> Int {
    guard let n = input.first?.count else { return 0 }

    var filteredIndicesForO2 = Array(input.indices)
    var filteredIndicesForCO2 = Array(input.indices)

    for j in 0..<n {
        if filteredIndicesForO2.count > 1 {
            filteredIndicesForO2 = mostSignificantBit(bitIndex: j, preferredBit: 1, input: input, filteredIndices: filteredIndicesForO2)
        }

        if filteredIndicesForCO2.count > 1 {
            filteredIndicesForCO2 = leastSignificantBit(bitIndex: j, preferredBit: 0, input: input, filteredIndices: filteredIndicesForCO2)
        }
    }

    return Int(String(input[filteredIndicesForO2[0]]), radix: 2)! * Int(String(input[filteredIndicesForCO2[0]]), radix: 2)!
}

private func mostSignificantBit(bitIndex: Int, input: [[Character]]) -> Int {
    let info = countBitOccurances(bitIndex: bitIndex, input: input, inputIndices: input.indices)
    return (info[1].count > info[0].count) ? 1 : 0
}

private func leastSignificantBit(
    bitIndex: Int,
    preferredBit: Int,
    input: [[Character]],
    filteredIndices: [Int]
) -> [Int] {
    significantBit(bitIndex: bitIndex, preferredBit: preferredBit, comparator: <, input: input, filteredIndices: filteredIndices)
}

private func mostSignificantBit(
    bitIndex: Int,
    preferredBit: Int,
    input: [[Character]],
    filteredIndices: [Int]
) -> [Int] {
    significantBit(bitIndex: bitIndex, preferredBit: preferredBit, comparator: >, input: input, filteredIndices: filteredIndices)
}


private func significantBit(
    bitIndex: Int,
    preferredBit: Int,
    comparator: (Int, Int) -> Bool,
    input: [[Character]],
    filteredIndices: [Int]
) -> [Int] {
    let info = countBitOccurances(bitIndex: bitIndex, input: input, inputIndices: filteredIndices)

    if info[0].count == info[1].count {
        return info[preferredBit].indices
    } else if comparator(info[0].count, info[1].count) {
        return info[0].indices
    } else {
        return info[1].indices
    }
}

private func countBitOccurances<T: Sequence>(
    bitIndex: Int,
    input: [[Character]],
    inputIndices: T
) -> [(count: Int, indices: [Int])] where T.Element == Int {
    var counts = [(count: Int, indices: [Int])](repeating: (0, []), count: 2)

    for rowIndex in inputIndices {
        let char = input[rowIndex][bitIndex]
        let countIndex = (char == "0") ? 0 : 1

        var info = counts[countIndex]
        info.count += 1
        info.indices.append(rowIndex)

        counts[countIndex] = info
    }

    return counts
}
