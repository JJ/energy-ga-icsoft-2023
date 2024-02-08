const std = @import("std");
pub const generate = @import("generate.zig").generate;
pub const ourRng = @import("utils.zig").ourRng;

test "all" {
    std.testing.refAllDecls(@This());
}
