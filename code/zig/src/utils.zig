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
pub fn countOnes(binaryString: []const u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += if (binaryChar == '1') 1 else 0;
    }
    return count;
}

// mutation operator that changes a single random character in a string
pub fn mutation(binaryString: *[]u8, rndGen: *std.rand.DefaultPrng) void {
    var index = rndGen.random().int(u32) % binaryString.len;
    binaryString.*[index] = if (binaryString.*[index] == '1') '0' else '1';
}

// Crossover operator that combines two strings, cutting them in two random points, interchanging the result
pub fn crossover(binaryString1: []const u8, binaryString2: []const u8, rndGen: *std.rand.DefaultPrng, allocator: std.mem.Allocator) ![2][]const u8 {
    var binaryString1Clone: []u8 = try allocator.dupeZ(u8, binaryString1);
    var binaryString2Clone: []u8 = try allocator.dupeZ(u8, binaryString2);
    var index1 = rndGen.random().int(u32) % binaryString1.len;
    var index2 = rndGen.random().int(u32) % binaryString1.len;
    // interchange values if index1 > index2
    if (index1 > index2) {
        var temp = index1;
        index1 = index2;
        index2 = temp;
    }

    // copy from binaryString1 to binaryString2Clone starting from indez1 to index2
    for (index1..index2) |i| {
        binaryString2Clone[i] = binaryString1[i];
        binaryString1Clone[i] = binaryString2[i];
    }

    const returningPair: [2][]const u8 = [_][]const u8{ binaryString1Clone, binaryString2Clone };
    return returningPair;
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
    var allocator = std.heap.page_allocator;
    var binaryString = try allocator.dupeZ(u8, "101010");
    defer allocator.free(binaryString);
    var copyBinaryString = try allocator.dupeZ(u8, "101010");
    defer allocator.free(copyBinaryString);
    var rndGen: std.rand.DefaultPrng = try ourRng();
    mutation(&binaryString, &rndGen);
    try expect(copyBinaryString.len == binaryString.len);
    std.debug.print("binaryString: {s}\n", .{binaryString});
    try expect(!std.mem.eql(u8, copyBinaryString, binaryString));
}

// test the crossover function
test "crossover" {
    const binaryString1: []const u8 = "101010";
    const binaryString2: []const u8 = "010101";
    var rndGen: std.rand.DefaultPrng = try ourRng();
    var allocator = std.heap.page_allocator;
    const crossoveredStrings: [2][]const u8 = try crossover(binaryString1, binaryString2, &rndGen, allocator);
    try expect(crossoveredStrings[0].len == binaryString1.len);
    try expect(crossoveredStrings[1].len == binaryString2.len);
    try expect(!std.mem.eql(u8, crossoveredStrings[0], binaryString1));
    try expect(!std.mem.eql(u8, crossoveredStrings[1], binaryString2));
}
