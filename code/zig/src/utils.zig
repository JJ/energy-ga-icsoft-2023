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

// MaxOnes or CountOnes implementation
fn countOnes(binaryString: []const u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += if (binaryChar == '1') 1 else 0;
    }
    return count;
}

// test the generator
test "random generators" {
    var firstRng: std.rand.DefaultPrng = try ourRng();
    var secondRng: std.rand.DefaultPrng = try ourRng();
    try expect(firstRng.random().int(i32) != secondRng.random().int(i32));
}

// test the countOnes function
test "countOnes" {
    var binaryString: []const u8 = "101010";
    try expect(countOnes(binaryString) == 3);
}
