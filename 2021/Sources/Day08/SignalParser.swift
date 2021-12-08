import Foundation

class SignalParser {
    private var lightPatternToDigitMap: [Int: Int]

    init() {
        self.lightPatternToDigitMap = SignalParser.computePatternMap()
    }

    func parseDigits(from input: (patterns: [String], digits: [String])) -> Int {
        let map = computeSegmentMap(from: input.patterns)
        return parseDigits(from: input.digits, segmentMap: map)
    }

    private func parseDigits(from digits: [String], segmentMap: [Character: Int]) -> Int {
        var num = 0
        for digitPattern in digits {
            let digit = parseDigit(digitPattern: digitPattern, segmentMap: segmentMap)
            num = (num * 10) + digit
        }

        return num
    }

    private func computeSegmentMap(from patterns: [String]) -> [Character: Int] {
        let groups = groupPatternsCountWise(patterns: patterns)
        var probableSignals = Array(repeating: Set<Character>(), count: 7)

        // probableSignals index map:
        //     0     |    a
        //   1   2   |  b   c
        //     3     |    d
        //   4   5   |  e   f
        //     6     |    g

        probableSignals[0] = groups[3][0].subtracting(groups[2][0])
        probableSignals[2] = groups[3][0].intersection(groups[2][0])
        probableSignals[5] = groups[3][0].intersection(groups[2][0])
        probableSignals[1] = groups[7][0].intersection(groups[4][0].subtracting(groups[2][0]))
        probableSignals[3] = groups[7][0].intersection(groups[4][0].subtracting(groups[2][0]))
        probableSignals[4] = groups[7][0].subtracting(groups[3][0].union(groups[4][0]))
        probableSignals[6] = groups[7][0].subtracting(groups[3][0].union(groups[4][0]))

        // For "a", "b", "g" signals
        var abgProbableSignals = groups[5].reduce(into: Set("abcdefg"), { $0.formIntersection($1) })
        abgProbableSignals.subtract(probableSignals[0])

        probableSignals[3].formIntersection(abgProbableSignals)
        abgProbableSignals.subtract(probableSignals[3])

        probableSignals[6].formIntersection(abgProbableSignals)

        probableSignals[4].subtract(probableSignals[6])
        probableSignals[1].subtract(probableSignals[3])

        // For "c", "d", "e" signals
        var cdeSignals = groups[7][0].subtracting(groups[6].reduce(into: Set("abcdefg"), { $0.formIntersection($1) }))
        cdeSignals.subtract(probableSignals[3])
        cdeSignals.subtract(probableSignals[4])

        probableSignals[2] = cdeSignals
        probableSignals[5].subtract(probableSignals[2])

        var output = [Character: Int]()
        for (index, chars) in probableSignals.enumerated() {
            guard let char = chars.first, chars.count == 1 else {
                preconditionFailure("Something went wrong, there should only be one character")
            }
            output[char] = index
        }

        return output
    }

    private func parseDigit(digitPattern: String, segmentMap: [Character: Int]) -> Int {
        let lightPatternID = computeLightPatternID(digitPattern: digitPattern, segmentMap: segmentMap)

        guard let digit = lightPatternToDigitMap[lightPatternID] else {
            fatalError("Unknown pattern \(digitPattern)")
        }

        return digit
    }

    private func computeLightPatternID(digitPattern: String, segmentMap: [Character: Int]) -> Int {
        var id = 0

        for char in digitPattern {
            guard let index = segmentMap[char] else {
                fatalError("Unknown character: \(char)")
            }
            id |= (1 << index)
        }

        return id
    }

    private func groupPatternsCountWise(patterns: [String]) -> [[Set<Character>]] {
        var countWiseGroups = Array(repeating: [Set<Character>](), count: 8)

        for pattern in patterns {
            guard pattern.count <= 7 else {
                fatalError("Invalid pattern: \(pattern)")
            }

            countWiseGroups[pattern.count].append(Set(pattern))
        }

        return countWiseGroups
    }

    private static func computePatternMap() -> [Int: Int] {
        //                       0:       1:       2:       3:       4:      5:       6:        7:       8:         9:
        //                      aaaa     ....     aaaa     aaaa     ....    aaaa     aaaa      aaaa     aaaa       aaaa
        //                     b    c   .    c   .    c   .    c   b    c  b    .   b    .    .    c   b    c     b    c
        //                     b    c   .    c   .    c   .    c   b    c  b    .   b    .    .    c   b    c     b    c
        //                      ....     ....     dddd     dddd     dddd    dddd     dddd      ....     dddd       dddd
        //                     e    f   .    f   e    .   .    f   .    f  .    f   e    f    .    f   e    f     .    f
        //                     e    f   .    f   e    .   .    f   .    f  .    f   e    f    .    f   e    f     .    f
        //                      gggg     ....     gggg     gggg     ....     gggg    gggg      ....     gggg       gggg
        //
        let lightPatterns = [ "abcefg", "cf",    "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf",   "abcdefg", "abcdfg" ]

        var map = [Int: Int]()
        for (digit, lightPattern) in lightPatterns.enumerated() {
            let patternID = lightPattern
                .lazy
                .compactMap({ $0.asciiValue })
                .map({ Int($0) - 97 })
                .map({ (1 << $0) })
                .reduce(0, |)

            map[patternID] = digit
        }

        return map
    }
}
