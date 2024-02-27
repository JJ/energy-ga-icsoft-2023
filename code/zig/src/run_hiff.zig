const std = @import("std");
const generate = @import("generate.zig").generate;

const ourRng = @import("utils.zig").ourRng;
const HIFF = @import("HIFF.zig").HIFF;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const chromosomes = try generate(allocator, prng.random(), stringLength, numStrings);

    var fitness = std.ArrayList(usize).init(allocator);

    for (chromosomes) |chromosome| {
        const thisChromosome: []const u8 = chromosome;

        try fitness.append(HIFF(thisChromosome));
    }
    std.debug.print("Results: {}\n", .{fitness.items.len});
}
