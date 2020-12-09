import Foundation

enum Instruction {
    case nop(Int)
    case acc(Int)
    case jmp(Int)
}

extension Instruction: Equatable { }

func part1(input: [String]) -> Int {
    var executedLines = Set<Int>()
    var acc = 0

    let instructions = input.map(parse(line:))
    var index = instructions.startIndex

    while index < instructions.endIndex {
        guard !executedLines.contains(index) else {
            return acc
        }

        let instruction = instructions[index]
        executedLines.insert(index)

        switch instruction {
        case .nop:
            index += 1
        case .acc(let value):
            acc += value
            index += 1
        case .jmp(let offset):
            index += offset
        }
    }

    return acc
}

func part2(input: [String]) -> Int {
    var instructions = input.map(parse(line:))

    func check() -> (Int, Int) {
        var executedLines = Set<Int>()
        var acc = 0

        var index = instructions.startIndex

        while index < instructions.endIndex {
            guard !executedLines.contains(index) else {
                break
            }

            let instruction = instructions[index]
            executedLines.insert(index)

            switch instruction {
            case .nop:
                index += 1
            case .acc(let value):
                acc += value
                index += 1
            case .jmp(let offset):
                index += offset
            }
        }

        return (acc, index)
    }

    var i = instructions.startIndex
    while i < instructions.endIndex {
        let instruction = instructions[i]

        switch instruction {
        case .acc: break

        case .jmp(let value):
            instructions[i] = .nop(value)
            let (acc, index) = check()
            if index >= instructions.endIndex {
                return acc
            }
            instructions[i] = instruction

        case .nop(let value):
            instructions[i] = .jmp(value)
            let (acc, index) = check()
            if index >= instructions.endIndex {
                return acc
            }
            instructions[i] = instruction
        }

        i += 1
    }

    fatalError("Couldn't find")
}


func parse(line: String) -> Instruction {
    let comps = line.split(separator: " ")

    guard comps.count == 2,
          let offset = Int(comps[1]) else {
        fatalError("Malformed instruction: \(line)")
    }

    if comps[0] == "nop" {
        return .nop(offset)
    } else if comps[0] == "acc" {
        return .acc(offset)
    } else if comps[0] == "jmp" {
        return .jmp(offset)
    } else {
        fatalError("Malformed instruction: \(line)")
    }
}

let input = Bundle
    .main
    .loadLines(from: "Day8")

//print(part1(input: input))
print(part2(input: input))
