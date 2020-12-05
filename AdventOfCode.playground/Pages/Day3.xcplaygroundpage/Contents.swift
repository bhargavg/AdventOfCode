import Foundation

func part1(input: [[Character]]) -> Int {
    countTrees(text: input, iIncrement: 1, jIncrement: 3)
}

func part2(input: [[Character]]) -> Int {
    [
      (i: 1, j: 1),
      (i: 1, j: 3),
      (i: 1, j: 5),
      (i: 1, j: 7),
      (i: 2, j: 1)
    ].map({
      countTrees(text: input, iIncrement: $0.i, jIncrement: $0.j)
    }).reduce(1, *)
}

func countTrees(
    text: [[Character]],
    iIncrement: Int,
    jIncrement: Int
) -> Int {
    let iLimit = text.count
    guard let jLimit = text.first?.count else { return 0 }

    let iSeq = sequence(first: 0, next: { last in
        let next = last + iIncrement
        return next < iLimit ? next : nil
    })

    let jSeq = sequence(first: 0, next: { last in
        return (last + jIncrement) % jLimit
    })

    return zip(iSeq, jSeq)
        .lazy
        .filter({ text[$0.0][$0.1] == "#" })
        .count
}


let chars = Bundle
    .main
    .loadText(from: "Day3")
    .map({ $0.split(separator: "\n") })
    .map({ $0.map(Array.init(_:)) })!

assert(part1(input: chars) == 191)
assert(part2(input: chars) == 1478615040)
