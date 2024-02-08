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

// test the function
test "random generators" {
    var firstRng: std.rand.DefaultPrng = try ourRng();
    var secondRng: std.rand.DefaultPrng = try ourRng();
    try expect(firstRng.random().int(i32) != secondRng.random().int(i32));
}
