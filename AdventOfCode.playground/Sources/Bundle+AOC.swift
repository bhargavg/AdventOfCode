import Foundation

extension Bundle {
    public func loadNums(from fileName: String) -> [Int] {
        guard let text = loadText(from: fileName) else { return [] }

        var nums = [Int]()

        let scanner = Scanner(string: text)
        while let val = scanner.scanInt() {
            nums.append(val)
        }

        return nums
    }

    public func loadLines(from fileName: String) -> [String] {
        loadText(from: fileName)?.split(separator: "\n", omittingEmptySubsequences: false).map({ String($0) }) ?? []
    }

    public func loadText(from fileName: String) -> String? {
        guard let data = loadData(from: fileName) else { return nil }
        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines)
    }

    public func loadData(from fileName: String) -> Data? {
        Bundle
            .main
            .path(forResource: fileName, ofType: "txt")
            .flatMap(FileManager.default.contents(atPath:))
    }
}
