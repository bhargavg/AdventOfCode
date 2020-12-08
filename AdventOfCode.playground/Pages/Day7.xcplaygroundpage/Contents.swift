import Foundation

func part1(input: [String]) -> Int {
    let (ins, _, _) = generateGraph(from: input)

    var output = Set<String>()
    var inwards = ins["shiny gold", default: Set()]

    while !inwards.isEmpty {
        var next = Set<String>()

        for node in inwards {
            output.insert(node)

            for parent in ins[node, default: Set()] {
                next.insert(parent)
            }
        }

        inwards = next
    }

    return output.count
}

func part2(input: [String]) -> Int {
    let (_, outs, counts) = generateGraph(from: input)

    var result = 0

    func helper(node: String, count: Int) {
        result += count

        for neighbour in outs[node, default: Set()] {
            helper(node: neighbour, count: count * (counts[node]?[neighbour] ?? 0))
        }
    }

    helper(node: "shiny gold", count: 1)

    return result - 1
}

func generateGraph(from input: [String]) -> (
    ins: [String: Set<String>],
    outs: [String: Set<String>],
    counts: [String: [String: Int]]
) {
    var ins  = [String: Set<String>]()
    var outs = [String: Set<String>]()
    var counts = [String: [String: Int]]()

    for line in input {
        let (node, neighbours) = process(line: line)

        for (neighbour, count) in neighbours {
            ins[neighbour, default: Set()].insert(node)
            outs[node, default: Set()].insert(neighbour)
            counts[node, default: [:]][neighbour, default: 0] = count
        }
    }

    return (ins, outs, counts)
}

func process(line: String) -> (
    node: String,
    neighbours: [String: Int]
) {
    guard let containerBagEndIndex = line.range(of: " bags contain ") else {
        fatalError("")
    }

    let node = String(line[...line.index(before: containerBagEndIndex.lowerBound)])

    let remaining = line[containerBagEndIndex.upperBound...]
    let neighbours = processNeighbours(segment: remaining)

    return (node, neighbours)
}

func processNeighbours<S: StringProtocol>(
    segment: S
) -> [String: Int] {
    guard segment != "no other bags." else {
        return [:]
    }

    let comps  = segment.split(separator: " ")
    var result = [String: Int]()

    for index in stride(from: comps.startIndex, to: comps.endIndex, by: 4) {
        // Each neighbour part should be of format:
        //  INT<SPACE>COLOR<SPACE>COLOR<SPACE>bag[s][.]
        //   1          2           3           4
        //
        // So, there has to be 4 parts
        guard comps.distance(from: index, to: comps.endIndex) >= 4 else {
            fatalError("Malformed: \(segment)")
        }

        guard let count = Int(comps[index]) else {
            fatalError("Coundn't get count")
        }

        let neighbour = comps[index + 1] + " " + comps[index + 2]

        // If same neighbour repeats again in same line,
        // sum counts
        result[neighbour, default: 0] += count
    }

    return result
}

let lines = Bundle
    .main
    .loadLines(from: "Day7")


assert(part1(input: lines) ==   205)
assert(part2(input: lines) == 80902)
