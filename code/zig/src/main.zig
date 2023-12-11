const std = @import("std");

fn countOnes(binaryString: []u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += binaryChar;
    }
    return count;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    // const stringLength = std.fmt.parseInt(u8, argsIterator.next(), 10);
    const stringLength = 1000;

    const numStrings = 40000;

    var i: u32 = 0;
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);

    while (i < numStrings) {
        i = i + 1;
        var binaryString = [_]u8{0} ** stringLength;

        var c: u32 = 0;
        while (c < stringLength) : (c += 1) {
            binaryString[c] = rnd.random().intRangeAtMost(u8, 0, 1);
        }

        const count = countOnes(&binaryString);
        _ = count;
    }
}
