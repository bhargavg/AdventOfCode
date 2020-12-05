import Foundation

func part1(input: [Int]) -> Int? {
    let sorted = input.sorted()

    let target = 2020

    var i = 0
    var j = sorted.count - 1

    while i < j {
        let sum = sorted[i] + sorted[j]

        if sum > target {
            j -= 1
        } else if sum < target {
            i += 1
        } else {
            return sorted[i] * sorted[j]
        }
    }

    return nil
}

func part2(input: [Int]) -> Int? {
    let sorted = input.sorted()

    var i = 0
    let target = 2020

    while i < sorted.count - 3 {

        var j = i + 1
        var k = sorted.count - 1

        while j < k {
            let sum = sorted[i] + sorted[j] + sorted[k]

            if sum > target {
                k -= 1
            } else if sum < target {
                j += 1
            } else {
                return sorted[i] * sorted[j] * sorted[k]
            }
        }

        i += 1
    }

    return nil
}


let nums = Bundle.main.loadNums(from: "Day1")

assert(part1(input: nums) == 1016131)
assert(part2(input: nums) == 276432018)
