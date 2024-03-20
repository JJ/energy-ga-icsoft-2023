const std = @import("std");

pub fn main() void {
    const generators: [3][]const u8 = .{ "chromosome_generator", "bool_chromosome_generator", "bitset_chromosome_generator" };
    inline for (generators) |g| {
        const path = "src/" ++ g ++ ".zig";
        std.debug.print("Building: {s}\n", .{path});
    }
}
