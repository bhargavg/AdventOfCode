import Foundation

public extension RandomAccessCollection {
    func movingWindows(of size: Int) -> [[Element]] {
        guard size > 0 else { return [] }

        var output = [[Element]]()

        for wStartIndex in indices {
            guard let wEndIndex = index(wStartIndex, offsetBy: size, limitedBy: endIndex) else {
                continue
            }

            output.append(Array(self[wStartIndex..<wEndIndex]))
        }

        return output
    }
}

