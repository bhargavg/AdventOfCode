import Foundation

func part1(input: [String]) -> Int {
    input
        .lazy
        .filter(isPassportHasAllFields(passport:))
        .count
}

func part2(input: [String]) -> Int {
    input
        .lazy
        .filter(isPassportHasAllFieldsWithValidValues(passport:))
        .count
}

func isPassportHasAllFields(passport: String) -> Bool {
    haveAllRequiredKeys(in: parseKeyValuePairs(of: passport))
}

func isPassportHasAllFieldsWithValidValues(passport: String) -> Bool {
    let kvDict = parseKeyValuePairs(of: passport)

    return haveAllRequiredKeys(in: kvDict)
        && haveValidValues(in: kvDict)
}

func haveAllRequiredKeys(in dict: [String: String]) -> Bool {
    var keysSet = Set(dict.keys)
    keysSet.remove("cid")

    let reqKeys = Set([ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" ])

    return reqKeys == keysSet
}

func haveValidValues(in dict: [String: String]) -> Bool {
    dict.allSatisfy({ isValue($0.value, validForKey: $0.key) })
}

func isValue(_ value: String, validForKey key: String) -> Bool {
    switch key {
    case "byr":
        let range = 1920...2002
        return Int(value).map(range.contains(_:)) ?? false

    case "iyr":
        let range = 2010...2020
        return Int(value).map(range.contains(_:)) ?? false

    case "eyr":
        let range = 2020...2030
        return Int(value).map(range.contains(_:)) ?? false

    case "hgt":
        if value.hasSuffix("cm") {
            let range = 150...193
            return Int(value.dropLast(2)).map(range.contains(_:)) ?? false
        } else if value.hasSuffix("in") {
            let range = 59...76
            return Int(value.dropLast(2)).map(range.contains(_:)) ?? false
        } else {
            return false
        }

    case "hcl":
        guard value.hasPrefix("#") else { return false }
        return value.dropFirst().allSatisfy({ ("0"..."9").contains($0) || ("a"..."f").contains($0) })

    case "ecl":
        return value == "amb"
            || value == "blu"
            || value == "brn"
            || value == "gry"
            || value == "grn"
            || value == "hzl"
            || value == "oth"

    case "pid":
        return value.count == 9 && Int(value) != nil

    case "cid":
        return true

    default:
        return false
    }
}

func parseKeyValuePairs(of passport: String) -> [String : String] {
    passport
        .split(separator: " ")
        .reduce(into: [String : String](), { (acc, kv) in
            let comps = kv.split(separator: ":")
            acc[String(comps[0])] = String(comps[1])
        })
}

func joinPassportLines(input: [String]) -> [String] {
    input.reduce(into: [""], { (acc, next) in
        if next == "" {
            acc.append("")
        } else {
            acc[acc.count - 1] =  acc[acc.count - 1].appending(" " + next)
        }
    })
}

let lines = joinPassportLines(input: Bundle.main.loadLines(from: "Day4"))

assert(part1(input: lines) == 230)
assert(part2(input: lines) == 156)
