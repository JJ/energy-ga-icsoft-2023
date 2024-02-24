const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// MaxOnes or CountOnes implementation
pub fn countOnes(binaryString: []const u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += if (binaryChar == '1') 1 else 0;
    }
    return count;
}

// mutation operator that changes a single random character in a string
pub fn mutation(binaryString: *[]u8, random: std.rand.Random) void {
    var index = random.int(u32) % binaryString.len;
    binaryString.*[index] = if (binaryString.*[index] == '1') '0' else '1';
}

// Crossover operator that combines two strings, cutting them in two random points, interchanging the result
pub fn crossover(allocator: std.mem.Allocator, binary_string_1: *[]u8, binary_string_2: *[]u8, random: std.rand.Random) !void {
    var binary_string_1Clone: []u8 = try allocator.dupeZ(u8, binary_string_1);
    defer allocator.free(binary_string_1Clone);
    var binary_string_2Clone: []u8 = try allocator.dupeZ(u8, binary_string_2);
    defer allocator.free(binary_string_2Clone);

    var index1 = random.int(u32) % binary_string_1.len;
    var index2 = random.int(u32) % binary_string_2.len;

    if (index1 > index2) {
        var temp = index1;
        index1 = index2;
        index2 = temp;
    }

    for (index1..index2) |i| {
        binary_string_2[i] = binary_string_1Clone[i];
        binary_string_1[i] = binary_string_2Clone[i];
    }
}

test "countOnes" {
    var binaryString: []const u8 = "101010";
    try expect(countOnes(binaryString) == 3);
}

test "mutation" {
    var allocator = std.heap.page_allocator;

    var binaryString = try allocator.dupeZ(u8, "101010");
    defer allocator.free(binaryString);
    var copyBinaryString = try allocator.dupeZ(u8, "101010");
    defer allocator.free(copyBinaryString);

    var random = try ourRng();
    mutation(&binaryString, random.random());
    try expect(copyBinaryString.len == binaryString.len);
    std.debug.print("binaryString: {s}\n", .{binaryString});
    try expect(!std.mem.eql(u8, copyBinaryString, binaryString));
}

test "crossover" {
    var prng = try ourRng();
    var allocator = std.heap.page_allocator;

    var binary_string_1 = try allocator.dupeZ(u8, "101010");
    defer allocator.free(binary_string_1);
    const copy_binary_string_1 = try allocator.dupeZ(u8, "101010");
    defer allocator.free(copy_binary_string_1);
    var binary_string_2 = try allocator.dupeZ(u8, "010101");
    defer allocator.free(binary_string_2);
    const copy_binary_string_2 = try allocator.dupeZ(u8, "010101");
    defer allocator.free(copy_binary_string_2);

    try crossover(allocator, &binary_string_1, &binary_string_2, prng.random());

    try expect(copy_binary_string_1.len == binary_string_1.len);
    try expect(copy_binary_string_2.len == binary_string_2.len);
    try expect(!std.mem.eql(u8, copy_binary_string_1, binary_string_1));
    try expect(!std.mem.eql(u8, copy_binary_string_2, binary_string_2));
}
