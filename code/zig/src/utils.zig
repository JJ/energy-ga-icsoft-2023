const std = @import("std");
const expect = std.testing.expect;

// function that generates a string array
pub fn ourRng() !std.rand.DefaultPrng {
    return std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
}

// test the generator
test "random generators" {
    var first_rng = try ourRng();
    for (1..10) |_| {
        var second_rng = try ourRng();
        try expect(first_rng.random().int(i32) != second_rng.random().int(i32));
        first_rng = second_rng;
    }
}
