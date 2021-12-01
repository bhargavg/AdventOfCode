import Foundation

// Copied mostly from: https://github.com/HarshilShah/AdventOfCode/blob/main/2020.playground/Pages/Day%2017.xcplaygroundpage/Contents.swift

func part1(activePoints: Set<Point>) -> Int {
    runSimulation(activePoints: activePoints, neighboursGenerator: threeDNeighboursGenerator(point:))
}

func part2(activePoints: Set<Point>) -> Int {
    runSimulation(activePoints: activePoints, neighboursGenerator: fourDNeighboursGenerator(point:))
}

func runSimulation(activePoints: Set<Point>, neighboursGenerator: (Point) -> Set<Point>) -> Int {
    var activePoints = activePoints

    for _ in 1 ... 6 {
        var pointsToConsider = activePoints
        for activePoint in activePoints {
            neighboursGenerator(activePoint).forEach({ pointsToConsider.insert($0) })
        }

        let newActivePoints = pointsToConsider
            .filter { point in
                let neighbours = neighboursGenerator(point)
                let activeNeighbours = neighbours.lazy.filter(activePoints.contains).count
                if activePoints.contains(point) {
                    return activeNeighbours == 2 || activeNeighbours == 3
                } else {
                    return activeNeighbours == 3
                }
            }

        activePoints = newActivePoints
    }

    return activePoints.count
}

struct Point: Hashable {
    let x: Int, y: Int, z: Int, w: Int
}

func threeDNeighboursGenerator(point: Point) -> Set<Point> {
    var neighbours = Set<Point>()

    for xx in (point.x - 1)...(point.x + 1) {
        for yy in (point.y - 1)...(point.y + 1) {
            for zz in (point.z - 1)...(point.z + 1) {
                if xx == point.x, yy == point.y, zz == point.z {
                    continue
                }

                neighbours.insert(Point(x: xx, y: yy, z: zz, w: point.w))
            }
        }
    }

    return neighbours
}

func fourDNeighboursGenerator(point: Point) -> Set<Point> {
    var neighbours = Set<Point>()

    for xx in (point.x - 1)...(point.x + 1) {
        for yy in (point.y - 1)...(point.y + 1) {
            for zz in (point.z - 1)...(point.z + 1) {
                for ww in (point.w - 1)...(point.w + 1) {
                    if xx == point.x, yy == point.y, zz == point.z, ww == point.w {
                        continue
                    }

                    neighbours.insert(Point(x: xx, y: yy, z: zz, w: ww))
                }
            }
        }
    }

    return neighbours
}

let input = """
    ####...#
    ......#.
    #..#.##.
    .#...#.#
    ..###.#.
    ##.###..
    .#...###
    .##....#
    """

let activePoints = input
    .split(separator: "\n")
    .enumerated()
    .reduce(into: Set<Point>(), { (acc, yAndLine) in
        let (y, line) = yAndLine

        for (x, char) in line.enumerated() where char == "#" {
            acc.insert(Point(x: x, y: y, z: 0, w: 0))
        }
    })

assert(part1(activePoints: activePoints) == 286)
assert(part2(activePoints: activePoints) == 960)
