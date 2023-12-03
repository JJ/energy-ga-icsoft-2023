const std = @import("std");

fn countOnes(binaryString: [1024]u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        if (binaryChar == '1') {
            count += 1;
        }
    }
    return count;
}

pub fn main() !void {
    const stringLength = 1024;

    const numStrings = 40000;

    var i: u32 = 0;
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);

    while (i < numStrings) {
        i = i + 1;
        var binaryString: [stringLength]u8 = undefined;

        var c: u32 = 0;
        while (c < stringLength) : (c += 1) {
            const randomBit = rnd.random().intRangeAtMost(u8, 0, 1);
            binaryString[c] = if (randomBit == 0) '0' else '1';
        }

        // Call the countOnes function
        const count = countOnes(binaryString);
        _ = count;
    }
}
