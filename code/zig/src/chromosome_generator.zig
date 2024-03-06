const std = @import("std");
const generate = @import("generate.zig").generate;
const ourRng = @import("utils.zig").ourRng;

pub fn main() !void {
    var buffer: [82000000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const output = try generate(allocator, prng.random(), stringLength, numStrings);
    defer {
        for (output) |str| allocator.free(str);
        allocator.free(output);
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{} \n", .{output.len});
}
