import Foundation

func part1(input: String) -> Int {
    var mask: String.SubSequence?
    var memory = [Int: Int]()

    for line in input.split(separator: "\n") {
        if line.starts(with: "mask = ") {
            mask = line.dropFirst(7)
            continue
        }

        guard let mask = mask else { fatalError("Mask not found") }

        var (memIndex, value) = parseMemoryInstruction(line: line)

        for (index, char) in mask.enumerated() {
            switch char {
            case "1":
                value |=  (34359738368 >> index)
            case "0":
                value &= ~(34359738368 >> index)
            default: continue
            }
        }

        memory[memIndex] = value
    }

    return memory.reduce(0, { $0 + $1.1 })
}

func part2(input: String) -> Int {
    var mask: String.SubSequence?
    var memory = [Int: Int]()

    for line in input.split(separator: "\n") {
        if line.starts(with: "mask = ") {
            mask = line.dropFirst(7)
            continue
        }

        guard let mask = mask else { fatalError("Mask not found") }

        let (memIndex, value) = parseMemoryInstruction(line: line)

        var floatingAddresses = Set<Int>()
        computeFloatingAddresses(
            originalAddress: memIndex,
            currentAddress: memIndex,
            mask: mask,
            maskBitIndex: mask.startIndex,
            output: &floatingAddresses
        )

        for address in floatingAddresses {
            memory[address] = value
        }
    }

    return memory.reduce(0, { $0 + $1.1 })
}

func computeFloatingAddresses<S: StringProtocol>(
    originalAddress: Int,
    currentAddress: Int,
    mask: S,
    maskBitIndex: String.Index,
    output: inout Set<Int>
) {
    guard maskBitIndex < mask.endIndex else {
        output.insert(currentAddress)
        return
    }

    switch mask[maskBitIndex] {
    case "0":
        computeFloatingAddresses(
            originalAddress: originalAddress,
            currentAddress: currentAddress,
            mask: mask,
            maskBitIndex: mask.index(after: maskBitIndex),
            output: &output
        )
    case "1":
        computeFloatingAddresses(
            originalAddress: originalAddress,
            currentAddress: currentAddress | (34359738368 >> mask.distance(from: mask.startIndex, to: maskBitIndex)),
            mask: mask,
            maskBitIndex: mask.index(after: maskBitIndex),
            output: &output
        )
    case "X":
        computeFloatingAddresses(
            originalAddress: originalAddress,
            currentAddress: currentAddress | (34359738368 >> mask.distance(from: mask.startIndex, to: maskBitIndex)),
            mask: mask,
            maskBitIndex: mask.index(after: maskBitIndex),
            output: &output
        )

        computeFloatingAddresses(
            originalAddress: originalAddress,
            currentAddress: currentAddress & ~(34359738368 >> mask.distance(from: mask.startIndex, to: maskBitIndex)),
            mask: mask,
            maskBitIndex: mask.index(after: maskBitIndex),
            output: &output
        )

    default:
        fatalError("Unknown bit")
    }
}


func parseMemoryInstruction<S: StringProtocol>(line: S) -> (address: Int, value: Int) {
    guard let mIndexStart = line.firstIndex(of: "["),
          let mIndexEnd = line.firstIndex(of: "]"),
          let spaceIndex = line.lastIndex(of: " ") else {
        fatalError()
    }

    let mIndexRange = line.index(after: mIndexStart)...line.index(before: mIndexEnd)
    let valueRange  = line.index(after: spaceIndex)...

    guard let memIndex = Int(line[mIndexRange]),
          let value = Int(line[valueRange]) else {
        fatalError()
    }

    return (memIndex, value)
}

let input = """
    mask = 00X1011010111X01X1X010X01X1111X11100
    mem[13879] = 56974
    mem[26072] = 842
    mem[47322] = 62104110
    mem[31450] = 372784
    mem[54364] = 2818920
    mask = 01000X10101XX0011000X00XXX00101X0101
    mem[13358] = 73976240
    mem[41121] = 3647124
    mask = 010000X01111X0011000X01010X1001100X0
    mem[49893] = 63539
    mem[63669] = 79316429
    mem[19136] = 256
    mem[1117] = 1244
    mem[56655] = 267815
    mem[22811] = 142
    mask = 0101011010111X0111X010110000XXX1010X
    mem[40297] = 21028792
    mem[16007] = 950419537
    mem[40907] = 2010
    mem[27377] = 525
    mem[0] = 209
    mem[41317] = 2312973
    mem[4641] = 1227100
    mask = X0X000101X111001110X011X1X1010X10100
    mem[24322] = 103589922
    mem[2572] = 1231
    mem[53327] = 814998856
    mem[30460] = 25015
    mask = 00000010XX101X11X0110100X0X001X010X1
    mem[50914] = 37339
    mem[50218] = 5021282
    mask = 0X0X00X01XX0110X1101X0X010000110X101
    mem[3780] = 51750101
    mem[8561] = 638
    mem[64747] = 215
    mem[51358] = 194347939
    mem[29912] = 9717
    mem[44684] = 418165
    mask = 0X0X00101011XXX11100001X0101X01101XX
    mem[1418] = 81827528
    mem[38228] = 399582
    mem[57488] = 7003
    mem[22080] = 112130
    mem[29467] = 2198074
    mem[32800] = 35048851
    mask = 010X00001011100111X0001X0100011010X1
    mem[16589] = 1922920
    mem[31011] = 88738170
    mem[35178] = 4791
    mem[17792] = 5560
    mem[50656] = 1695
    mem[22720] = 1584409
    mem[54364] = 1486
    mask = 01XX011010X110XXX1X001010X01000X1011
    mem[19230] = 13477
    mem[41397] = 781359
    mem[11599] = 7687201
    mem[2817] = 26775
    mask = X10001XX1000100X1X00001X01X100011100
    mem[288] = 1886
    mem[32911] = 326403
    mem[48084] = 66681
    mask = 00001000X011110X11011000X0X000XX10X1
    mem[41020] = 3202
    mem[21434] = 5634478
    mask = 00X0XX001011X0X1X10X100001110111X011
    mem[33545] = 1876
    mem[28976] = 581977039
    mask = 0X11011010111101011000X1101X000X1110
    mem[19071] = 770610413
    mem[20064] = 1694
    mem[43482] = 2871
    mem[46365] = 3148234
    mem[52059] = 3513
    mem[18760] = 1548
    mem[61977] = 605
    mask = 010X01XX1X11100X11001X10X10110000001
    mem[53801] = 111695
    mem[11683] = 168184
    mem[20469] = 1949
    mask = X1010110X01111011100X010000XX0000000
    mem[55872] = 2261951
    mem[13140] = 15964
    mem[45204] = 22572
    mask = X10X0000XX111X01100011X11X1100101101
    mem[56655] = 124863920
    mem[32800] = 20227
    mem[58864] = 42605725
    mem[59474] = 859
    mem[59729] = 141193
    mem[18342] = 1631
    mask = 01100XX01011100111X00010XX01X0XX010X
    mem[13572] = 3383121
    mem[32800] = 25726954
    mem[54193] = 54397
    mem[3305] = 251510
    mem[52294] = 33972
    mask = 0100X0XX10XX11X11101001010X1X110X100
    mem[3991] = 3201095
    mem[19248] = 1173
    mem[17507] = 684436
    mem[37324] = 694
    mem[11150] = 44468495
    mem[16853] = 3978967
    mem[10293] = 3552
    mask = X0X00000X01010011011011X1000X01XX001
    mem[54689] = 1224
    mem[36536] = 33407636
    mem[22811] = 296513
    mem[58491] = 109654
    mask = 010XX1111011000X1000X1000100X00011X0
    mem[20982] = 1468
    mem[15854] = 13972
    mem[55563] = 121451
    mem[28871] = 732
    mask = 00100X100001000001001101XX100X10XX10
    mem[37549] = 11144610
    mem[58939] = 280786876
    mem[38833] = 1473210
    mem[44075] = 571
    mem[21698] = 5427778
    mem[35937] = 544693
    mask = 0100011010111XX10X00011011X010110110
    mem[63719] = 36151477
    mem[43205] = 79985
    mem[9431] = 23613381
    mem[38228] = 93679
    mem[45544] = 946568
    mask = 0X000000101010011101110X11001000XX00
    mem[2730] = 8086855
    mem[50422] = 3607
    mem[9544] = 3738
    mask = 0X0XXXX010X1100111100010000001010010
    mem[17216] = 2231300
    mem[40965] = 30453
    mem[43536] = 1780
    mem[26440] = 712936
    mem[26845] = 445304638
    mask = 01X000X1X0101001101111X1000X0001X0XX
    mem[34736] = 35
    mem[23584] = 62941351
    mask = 01X000XX1110XX11XX10010000010X00X110
    mem[35014] = 2725
    mem[31317] = 3
    mask = 000XX0XX101010X1X0X111X0100001100001
    mem[372] = 21946096
    mem[10488] = 41777407
    mem[23528] = 1708407
    mem[60206] = 182569990
    mem[44075] = 816675
    mem[43028] = 618865
    mask = 0X00X000101X1X01110XX01XX0000011X001
    mem[955] = 17506
    mem[41317] = 3162029
    mem[37] = 9168685
    mem[24435] = 33494
    mem[10291] = 901681
    mem[26688] = 23163
    mask = 0100100110X111011XX10010101101101X00
    mem[53694] = 184478
    mem[38156] = 140154654
    mem[3645] = 99833620
    mem[5194] = 7438
    mem[13132] = 187583
    mem[10626] = 213169401
    mask = 0X00X11X1011000X100000XXX0001010XX11
    mem[58468] = 3932
    mem[47108] = 13422709
    mem[20791] = 25670347
    mask = 0100010010111000110000X1X11111X0X100
    mem[64332] = 58063181
    mem[20791] = 97103200
    mem[21178] = 704
    mask = 010X000010101X0X11X111001100X1X011XX
    mem[29912] = 96861
    mem[11661] = 15933204
    mem[31973] = 1597059
    mask = 010X0010001XX001110011X0000X00101110
    mem[54377] = 929
    mem[1578] = 1628469
    mem[9066] = 1039223
    mem[54819] = 131459054
    mem[59746] = 97979749
    mem[21742] = 919
    mask = 010X000010111X011110X100X00X0000X00X
    mem[25877] = 1030474
    mem[40848] = 441
    mem[19136] = 40
    mem[41305] = 509818516
    mask = 11010011XX111011110X111011X11X00X100
    mem[56916] = 23553145
    mem[43067] = 120593523
    mem[41993] = 121958
    mem[16589] = 469
    mask = 00000XX0101111011101X1011XX1001XXXX0
    mem[44363] = 1739
    mem[15915] = 49544
    mem[5729] = 173493396
    mem[29213] = 41122
    mem[50656] = 1531
    mask = 0X010X1010111X0111000X1XX10100X101XX
    mem[58111] = 1227
    mem[45142] = 3293
    mem[30952] = 2965075
    mem[25181] = 578696
    mem[50656] = 60702685
    mask = 0111011010111XX10100X100110101000X1X
    mem[59881] = 82070
    mem[60524] = 62394
    mem[35663] = 1981
    mem[27322] = 216531615
    mem[8965] = 14469
    mem[13388] = 1148662
    mem[13342] = 92607190
    mask = X1000XX110X0111XXX010010X00101110101
    mem[2228] = 40376
    mem[64755] = 1327525
    mask = 11010010X0XX10X11X0X1X011001101X110X
    mem[15280] = 2364003
    mem[19478] = 72063090
    mem[8497] = 28240
    mem[45678] = 2811
    mem[52231] = 39955
    mask = 0X001111X011000010X01011X1000XX00X11
    mem[24827] = 1639
    mem[13879] = 119218
    mem[17610] = 6101768
    mem[48448] = 3972
    mask = XX0000X0X11110X110001111011X00010101
    mem[65388] = 9968
    mem[26462] = 45065510
    mem[27496] = 70270
    mask = 01010X1X111X1001101X101X0XX000000001
    mem[10134] = 755
    mem[34940] = 3959699
    mem[26321] = 156
    mem[63789] = 36543477
    mask = X10X001010111001X1000100001XX00X101X
    mem[59095] = 888920
    mem[26072] = 189525541
    mem[41506] = 78022
    mask = 01X000101X1X10X11010X1X010X1010X011X
    mem[19618] = 43629
    mem[16853] = 176218496
    mem[27558] = 9383
    mask = 000000X01011101111001XX00000X0000110
    mem[47738] = 782
    mem[9654] = 14755
    mask = 01X0X0001X01X101110X00000000000X0101
    mem[21742] = 34626297
    mem[10621] = 1418350
    mem[45805] = 3784031
    mask = 01XX01001011101X010X001001X1010X0100
    mem[18511] = 458
    mem[4597] = 8053
    mem[34914] = 902
    mem[11895] = 2319205
    mem[54291] = 7059674
    mem[60178] = 1495
    mem[64432] = 22061
    mask = 1X110010001110011X0X01100X1XX0X01XX0
    mem[9055] = 462699
    mem[35882] = 554265333
    mem[50939] = 52443722
    mem[20552] = 160408413
    mask = 0100010010111001X100000X01X1001001X1
    mem[28976] = 404
    mem[64843] = 813
    mem[57066] = 899
    mem[16179] = 3033125
    mask = X101X01X101110X1110011X0X00010X01001
    mem[63922] = 122921015
    mem[47325] = 66631
    mem[34914] = 122827
    mem[41369] = 723416
    mem[26321] = 350572
    mem[10260] = 11917171
    mem[20396] = 112670
    mask = 00X100101011100111XX010X011X0XX001XX
    mem[11150] = 875126074
    mem[28760] = 25307778
    mem[14951] = 445519
    mem[54291] = 394307
    mem[19109] = 15584261
    mem[8221] = 524
    mask = 01000XX011111001100000001101X111X101
    mem[58015] = 18497
    mem[63992] = 530980167
    mem[26915] = 14357281
    mem[42401] = 12123838
    mem[65275] = 14601815
    mask = 010X00X0100011X011010010X00XX100010X
    mem[49005] = 39006890
    mem[121] = 119847895
    mem[16179] = 737050
    mem[52215] = 11770
    mask = 010XX0001X10X101110XX10X00000X100111
    mem[40066] = 1188
    mem[27727] = 10855
    mem[47207] = 113852179
    mask = 0X10011XX01X1011110000011X11X0XX101X
    mem[27558] = 1280
    mem[18441] = 312
    mem[22675] = 2746277
    mem[54987] = 120268
    mask = 1101XX1010111X011XX01XX0110000001110
    mem[8285] = 6819893
    mem[56655] = 10287
    mem[39027] = 158
    mem[25922] = 2798
    mem[22261] = 36850389
    mem[46394] = 48894888
    mask = X1X10010X011100111001000XX100X1X1X00
    mem[24614] = 1802
    mem[13232] = 499261
    mask = 01XX0X1010111XX11100X011010100X0X101
    mem[63992] = 12600674
    mem[56655] = 99142656
    mem[9273] = 302251593
    mask = XX000XXX1011101111XX0010000100111X00
    mem[18088] = 20379649
    mem[47508] = 111520085
    mem[38545] = 90881967
    mem[21514] = 16333
    mem[35731] = 816238944
    mask = 110111101X11X1011010X10010000111101X
    mem[13890] = 4842901
    mem[23610] = 19829
    mem[21900] = 31928769
    mem[10595] = 228191
    mem[13375] = 24467
    mem[45544] = 149815
    mask = 010XX1X0101X100X110X1111010X1100X10X
    mem[13358] = 7851
    mem[18277] = 1322
    mem[24517] = 6165
    mem[19856] = 93677767
    mask = 010X0110101XX0011100X000X00000100111
    mem[60820] = 549270
    mem[42355] = 609632
    mem[35546] = 241510
    mem[59340] = 57067
    mask = 010X00X0X0101X001X01111011X00XX01010
    mem[58491] = 456443643
    mem[49058] = 86242
    mem[24702] = 25105
    mem[35001] = 88082598
    mem[36988] = 23981732
    mem[54815] = 19064841
    mem[52231] = 329
    mask = 0XX0001X11101XX011X1X1000000110111X1
    mem[7504] = 475530227
    mem[29138] = 11235
    mem[56376] = 76699622
    mask = 0011XXX01011100X1110X111011XX1110X00
    mem[52184] = 60066
    mem[64705] = 2343316
    mem[43172] = 28305258
    mem[5362] = 2133
    mem[38763] = 2754100
    mem[52032] = 7390
    mem[2572] = 19579691
    mask = 010XX00010101001101X111X000101110011
    mem[29623] = 24098
    mem[8946] = 24951998
    mem[11382] = 184167
    mem[47522] = 6393093
    mask = XX01001010X11X011110X000XX000100X0X1
    mem[10260] = 661
    mem[25012] = 11390
    mask = 0100001010001101110101100XX110X01XX1
    mem[9055] = 297216
    mem[49887] = 26800
    mem[18511] = 3731
    mem[26845] = 42990
    mask = 00X0X00010101X1X1001100011X001100001
    mem[19591] = 197388201
    mem[51460] = 1032
    mem[9600] = 934060
    mem[58791] = 1646732
    mem[50283] = 1235563
    mem[26455] = 5018620
    mem[288] = 481559
    mask = 010X001010110X0X1X001111000XX010011X
    mem[13491] = 1626583
    mem[36536] = 239
    mem[56224] = 9125
    mem[28105] = 22015873
    mem[44531] = 8125
    mem[18760] = 25964
    mask = X101000011111X011110100011000X010X0X
    mem[58864] = 709865577
    mem[32976] = 303129
    mem[44109] = 8025520
    mem[51706] = 3030478
    mask = 00X01X0010101X0X1X011X110000X10101X1
    mem[53349] = 146801393
    mem[372] = 27164788
    mask = 0X00000010101X011XX11110X000XX1X0001
    mem[27091] = 1227
    mem[3194] = 234
    mem[37] = 4066397
    mem[43559] = 17240
    mem[36904] = 23282
    mem[9186] = 622901569
    mem[58468] = 208767
    mask = 00XX00X010X11101X101111001110100101X
    mem[9251] = 230
    mem[61367] = 78432672
    mem[37478] = 2594
    mem[64797] = 71052818
    mem[30018] = 11711518
    mem[20324] = 64836
    mem[61185] = 1433
    mask = 010000X0101X11001101011001100XXX0010
    mem[31581] = 232228
    mem[51766] = 13503
    mem[46129] = 1071
    mem[27845] = 3969749
    mem[17643] = 282089
    mem[60524] = 10654
    mask = 010X00X01X1110011XX01010XX00X0X10101
    mem[41317] = 20899132
    mem[17792] = 1949
    mem[1117] = 4931
    mem[21452] = 423952
    mem[29912] = 36667871
    mem[10260] = 15401611
    mem[28642] = 2840753
    mask = 000000X0101111011101XXXX000X001X01X1
    mem[57488] = 297477423
    mem[8228] = 240002
    mem[45051] = 1209316
    mem[65123] = 1339
    mask = 0100000010101X001111X1011X0001X0X00X
    mem[25750] = 10538421
    mem[59160] = 13024648
    mem[7581] = 521295867
    mem[44127] = 10349
    mem[20791] = 263486916
    mem[58844] = 37364
    mem[44165] = 213775351
    mask = 010X0X0010XX10011100001X0X0X1X0001X1
    mem[20221] = 7207
    mem[2326] = 247233
    mem[54001] = 1782454
    mem[41112] = 61297
    mem[45994] = 12285
    mask = 00X00010X0X1001111000010X0X1001XX10X
    mem[22080] = 50449
    mem[32446] = 69686
    mem[46129] = 6052251
    mem[45810] = 6931
    mem[2730] = 17348930
    mem[25557] = 22866081
    mem[53007] = 2662
    mask = 00000X1010111X0111011X01000X10X0XX01
    mem[26747] = 237030337
    mem[47589] = 912076
    mem[7333] = 105514
    mem[62613] = 1442076
    mem[293] = 1883
    mask = X1001X1010101111110XX010100000100X01
    mem[64864] = 522211793
    mem[381] = 395572639
    mem[39482] = 641
    mem[47108] = 37814
    mask = 00X00111101110111X001101001110XXX00X
    mem[16554] = 1304638
    mem[56666] = 189089562
    mem[12934] = 138931
    mem[63122] = 607569
    mem[37147] = 131399848
    mask = 0X1X11101XX11X0X11100111X100001111X0
    mem[24256] = 156773
    mem[14436] = 485469048
    mem[20781] = 376
    mem[23284] = 879110
    mem[2582] = 42478
    mem[39002] = 3578
    mask = 0000XX0X101010011XX000X0000X01100X01
    mem[40945] = 11048
    mem[36114] = 13782606
    mem[2325] = 185202507
    mem[33715] = 4806448
    mem[61649] = 3756998
    mem[55852] = 117
    mask = 01000000101X1011110010010XXX0XX11110
    mem[5881] = 13440134
    mem[22720] = 962895873
    mem[25142] = 11785
    mask = 0101011010111001010011100XX0011111XX
    mem[586] = 209
    mem[51207] = 145606
    mem[21220] = 62604
    mem[45100] = 34084913
    mem[30986] = 310031
    mem[56443] = 483530965
    mask = 0000100000X1X10X11X1100010100X011001
    mem[41487] = 38587945
    mem[21434] = 249215427
    mem[7230] = 111149021
    mask = X101X010XXX1100101X0X10100100111111X
    mem[40840] = 2606
    mem[63190] = 2447
    mem[60328] = 40915
    mem[45620] = 13499
    mask = 001X0010101110X1X1X0X11X0010X0X001X0
    mem[62719] = 785
    mem[19974] = 42859172
    mem[51864] = 44741
    mem[63056] = 27482866
    mask = X0X1X0101011X001X100101100101XX1X000
    mem[39205] = 10997188
    mem[14100] = 29987320
    mem[616] = 278639655
    mask = 0100000X10101X011X1111000X00X0111000
    mem[49278] = 610
    mem[9321] = 333537
    mem[22656] = 4066
    mem[8228] = 2791399
    mem[9251] = 3866
    mask = X00100X01011100X1X0XX000111011X00011
    mem[58260] = 459
    mem[18311] = 40779317
    mem[10291] = 3362
    mem[16865] = 1236
    mask = X100X000X010110111X0001100000001X011
    mem[1826] = 108687499
    mem[4087] = 243589
    mem[47489] = 474492676
    mem[4129] = 16244
    mem[29617] = 819406
    mem[43545] = 108512190
    mask = 010X0XX0101110X1X100X01X000X0X110100
    mem[57918] = 102433847
    mem[33825] = 9
    mem[372] = 230834
    mem[19591] = 7380
    mem[65409] = 98189
    mem[36391] = 3033
    mask = X101X000101111011000X10X100100100000
    mem[54029] = 347451
    mem[28001] = 82660784
    mask = 01X0000010101001X1000000X0X000110101
    mem[37266] = 1643
    mem[52294] = 242323894
    mem[40965] = 11451
    mem[52532] = 1191041
    mem[1994] = 1830445
    mem[16066] = 694
    mask = 0X100010X0X1XX0X01001X10X1100X110000
    mem[60293] = 92656839
    mem[8228] = 24889387
    mem[13951] = 25158
    """


assert(part1(input: input) == 5902420735773)
assert(part2(input: input) == 3801988250775)
