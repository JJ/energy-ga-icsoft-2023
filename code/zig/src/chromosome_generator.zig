const std = @import("std");
const generate = @import("generate.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next().?;
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    var i: u32 = 0;
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init(0);

    while (i < numStrings) {
        i = i + 1;
        var binaryString = try allocator.alloc(u8, stringLength);

        var c: u32 = 0;
        while (c < stringLength) : (c += 1) {
            binaryString[c] = rnd.random().intRangeAtMost(u8, 0, 1);
        }
    }
}
