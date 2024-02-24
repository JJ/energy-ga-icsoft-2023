const std = @import("std");
pub const generate = @import("generate.zig").generate;
pub const ourRng = @import("utils.zig").ourRng;
pub const crossover = @import("crossover.zig").crossover;

test "all" {
    std.testing.refAllDecls(@This());
}
