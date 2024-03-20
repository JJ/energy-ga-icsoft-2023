const std = @import("std");
const generate = @import("bitset_generate.zig").generate;
const ourRng = @import("utils.zig").ourRng;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    const numStrings = 40000;

    const output = try generate(allocator, prng.random(), std.bit_set.StaticBitSet(2048), numStrings);
    defer allocator.free(output);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{} \n", .{output.len});
}
