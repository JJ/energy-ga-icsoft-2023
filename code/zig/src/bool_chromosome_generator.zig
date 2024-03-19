const std = @import("std");
const boolGenerate = @import("bool_generate.zig").boolGenerate;
const ourRng = @import("utils.zig").ourRng;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const output = try boolGenerate(allocator, prng.random(), stringLength, numStrings);
    std.debug.print("Generated {} strings of length {}\n", .{ numStrings, stringLength });
    defer {
        for (output) |str| allocator.free(str);
        allocator.free(output);
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{} \n", .{output.len});
}
