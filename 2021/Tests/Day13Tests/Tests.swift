import XCTest
@testable import Day13

final class Day1eTests: XCTestCase {
    func testPart1Example() throws {
        XCTAssertEqual(part1(input: try parseInput(path: "Inputs")), 17)
    }

    func testPart2Example() throws {
        let expected = """
        #####
        #...#
        #...#
        #...#
        #####
        .....
        .....
        """

        XCTAssertEqual(part2(input: try parseInput(path: "Inputs")), expected)
    }

    //MARK: - Utils
    private func parseInput(path: String) throws -> (coordinates: [(x: Int, y: Int)], instructions: [FoldInstruction])  {
        guard let contents = try Bundle.module.url(forResource: path, withExtension: "txt").map(String.init(contentsOf:)) else {
            return ([], [])
        }

        var lines = contents.split(separator: "\n").makeIterator()

        var coordinates = [(x: Int, y: Int)]()
        var instructions = [FoldInstruction]()

        while let line = lines.next() {
            if let coordinate = parseCoordinate(line: line) {
                coordinates.append(coordinate)
            } else if let instruction = parseFoldInstruction(line: line) {
                instructions.append(instruction)
            }
        }

        return (coordinates, instructions)
    }

    private func parseCoordinate<T: StringProtocol>(line: T) -> (x: Int, y: Int)? {
        let comps = line.split(separator: ",")

        guard comps.count == 2,
              let x = Int(comps[0]),
              let y = Int(comps[1]) else {
            return nil
        }

        return (x, y)
    }

    private func parseFoldInstruction<T: StringProtocol>(line: T) -> FoldInstruction? {
        let rootComps = line.split(separator: " ")

        guard rootComps.count == 3, rootComps[0] == "fold", rootComps[1] == "along" else { return nil }

        let instructionComps = rootComps[2].split(separator: "=")

        guard instructionComps.count == 2 else { return nil }

        switch instructionComps[0] {
        case "x":
            return Int(instructionComps[1]).map({ .left($0) })
        case "y":
            return Int(instructionComps[1]).map({ .up($0) })
        default:
            return nil
        }
    }
}
