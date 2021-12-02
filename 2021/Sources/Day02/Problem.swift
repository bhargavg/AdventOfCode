import Foundation

func part1(input: [(direction: String, offset: Int)]) -> Int {
    var x = 0
    var y = 0

    for (direction, offset) in input {
        switch direction {
        case "forward": x += offset
        case "up": y -= offset
        case "down": y += offset
        default: fatalError("Unknown command")
        }
    }

    return x * y
}

func part2(input: [(direction: String, offset: Int)]) -> Int {
    var x = 0
    var y = 0
    var aim = 0

    for (direction, offset) in input {
        switch direction {
        case "down":
            aim += offset
        case "up":
            aim -= offset
        case "forward":
            x += offset
            y += (aim * offset)
        default: fatalError("Unknown command")
        }
    }

    return x * y
}
