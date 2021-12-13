import Foundation

public func part1(input: [String: Set<String>]) -> Int {
    return dfs(node: "start", adjList: input, state: (visited: Set<String>(), isDuplicateSmallVisited: true))
}

public func part2(input: [String: Set<String>]) -> Int {
    return dfs(node: "start", adjList: input, state: (visited: Set<String>(), isDuplicateSmallVisited: false))
}

private func dfs(
    node: String,
    adjList: [String: Set<String>],
    state: (visited: Set<String>, isDuplicateSmallVisited: Bool)
) -> Int {
    guard node != "end" else {
        return 1
    }

    guard let neighbors = adjList[node] else {
        fatalError("Unknown node found: \(node)")
    }

    var newState = state
    if node.isLowercase {
        if state.visited.contains(node) && state.isDuplicateSmallVisited {
            return 0
        }

        newState.visited.insert(node)
        newState.isDuplicateSmallVisited = state.isDuplicateSmallVisited || state.visited.contains(node)
    }

    var count = 0
    for neighbor in neighbors {
        let shouldVisitNeighbor =
            (node == "start")
            || (neighbor == "end")
            || (neighbor != "start")

        guard shouldVisitNeighbor else { continue }

        count += dfs(node: neighbor, adjList: adjList, state: newState)
    }

    return count
}



extension String {
    var isLowercase: Bool {
        allSatisfy(\.isLowercase)
    }

    var isUppercase: Bool {
        !isLowercase
    }
}
