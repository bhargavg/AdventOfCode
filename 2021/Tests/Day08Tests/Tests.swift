import XCTest
@testable import Day08

final class Day08Tests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 26)
    }

    func testPart2Example() throws {
        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), 61229)
    }

    func testParser() throws {
        let parsed = try parseInput(path: "Inputs")
        let expected = [
            (patterns: ["be", "cfbegad", "cbdgef", "fgaecd", "cgeb", "fdcge", "agebfd", "fecdb", "fabcd", "edb"], digits: ["fdgacbe", "cefdb", "cefbgd", "gcbe"]),
            (patterns: ["edbfga", "begcd", "cbg", "gc", "gcadebf", "fbgde", "acbgfd", "abcde", "gfcbed", "gfec"], digits: ["fcgedb", "cgb", "dgebacf", "gc"]),
            (patterns: ["fgaebd", "cg", "bdaec", "gdafb", "agbcfd", "gdcbef", "bgcad", "gfac", "gcb", "cdgabef"], digits: ["cg", "cg", "fdcagb", "cbg"]),
            (patterns: ["fbegcd", "cbd", "adcefb", "dageb", "afcb", "bc", "aefdc", "ecdab", "fgdeca", "fcdbega"], digits: ["efabcd", "cedba", "gadfec", "cb"]),
            (patterns: ["aecbfdg", "fbg", "gf", "bafeg", "dbefa", "fcge", "gcbea", "fcaegb", "dgceab", "fcbdga"], digits: ["gecf", "egdcabf", "bgf", "bfgea"]),
            (patterns: ["fgeab", "ca", "afcebg", "bdacfeg", "cfaedg", "gcfdb", "baec", "bfadeg", "bafgc", "acf"], digits: ["gebdcfa", "ecba", "ca", "fadegcb"]),
            (patterns: ["dbcfg", "fgd", "bdegcaf", "fgec", "aegbdf", "ecdfab", "fbedc", "dacgb", "gdcebf", "gf"], digits: ["cefg", "dcbef", "fcge", "gbcadfe"]),
            (patterns: ["bdfegc", "cbegaf", "gecbf", "dfcage", "bdacg", "ed", "bedf", "ced", "adcbefg", "gebcd"], digits: ["ed", "bcgafe", "cdgba", "cbgef"]),
            (patterns: ["egadfb", "cdbfeg", "cegd", "fecab", "cgb", "gbdefca", "cg", "fgcdab", "egfdb", "bfceg"], digits: ["gbdfcae", "bgc", "cg", "cgb"]),
            (patterns: ["gcafb", "gcf", "dcaebfg", "ecagb", "gf", "abcdeg", "gaef", "cafbge", "fdbac", "fegbdc"], digits: ["fgae", "cfgab", "fg", "bagce"]),
        ]

        XCTAssertEqual(parsed.count, expected.count)

        for (parsedItem, expectedItem) in zip(parsed, expected) {
            XCTAssertEqual(parsedItem.patterns, expectedItem.patterns)
            XCTAssertEqual(parsedItem.digits, expectedItem.digits)
        }
    }

    // MARK: - Utils
    private func parseInput(path: String) throws -> [(patterns: [String], digits: [String])]  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return []
        }

        return contents.split(separator: "\n").compactMap(parse(line:))
    }

    private func parse<T: StringProtocol>(line: T) -> (patterns: [String], digits: [String])? {
        let comps = line.split(separator: "|")

        guard comps.count == 2 else {
            print("Invalid format: \(line)")
            return nil
        }

        return (parseDigitPatterns(from: comps[0]), parseDigitPatterns(from: comps[1]))
    }

    private func parseDigitPatterns<T: StringProtocol>(from input: T) -> [String] {
        return input.split(separator: " ").map(String.init(_:))
    }
}
