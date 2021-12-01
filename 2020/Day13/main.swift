import Foundation

func part1<S: StringProtocol>(input: [S]) -> Int {
    let timestamp = Int(input[0])!
    let busIDs = input[1].split(separator: ",").compactMap({ Int($0) })

    var earliestBusInfo: (busID: Int, busTimestamp: Int)?

    for busID in busIDs {
        let busNextTimestamp = busID * Int((Double(timestamp) / Double(busID)).rounded(.up))

        if let eBusInfo = earliestBusInfo, eBusInfo.busTimestamp < busNextTimestamp {
            continue
        }

        earliestBusInfo = (busID, busNextTimestamp)
    }

    guard let eBusInfo = earliestBusInfo else { fatalError() }

    return eBusInfo.busID * (eBusInfo.busTimestamp - timestamp)
}

func part2<S: StringProtocol>(input: [S]) -> Int {
    let busIDs = input[1]

    var busIDOffsetPairs = [(id: Int, offset: Int)]()
    var offset = 0
    for busID in busIDs.split(separator: ",") {
        defer { offset += 1}
        guard busID != "x" else { continue }
        busIDOffsetPairs.append((id: Int(busID)!, offset: offset))
    }


    var lastMultiple = 1
    var timestamp = 0

    for (id, offset) in busIDOffsetPairs {
        while (timestamp + offset) % id != 0 {
            timestamp += lastMultiple
        }

        lastMultiple *= id
    }

    return timestamp
}



let input = """
    1002460
    29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,601,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,x,x,463,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37
    """.split(separator: "\n")


assert(part1(input: input) == 4808)
assert(part2(input: input) == 741745043105674)
