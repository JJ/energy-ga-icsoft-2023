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

// mutation operator that changes a single random character in a string
fn mutation(binaryString: []const u8, rndGen: *std.rand.DefaultPrng, allocator: std.mem.Allocator) ![]const u8 {
    var binaryStringClone: []u8 = try allocator.dupeZ(u8, binaryString);
    var index = rndGen.random().int(u32) % binaryString.len;
    binaryStringClone[index] = if (binaryStringClone[index] == '1') '0' else '1';
    return binaryStringClone;
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

// test the mutation function
test "mutation" {
    const binaryString: []const u8 = "101010";
    var rndGen: std.rand.DefaultPrng = try ourRng();
    var allocator = std.heap.page_allocator;
    const mutatedString: []const u8 = try mutation(binaryString, &rndGen, allocator);
    try expect(mutatedString.len == binaryString.len);
    try expect(!std.mem.eql(u8, mutatedString, binaryString));
}
