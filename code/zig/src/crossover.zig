const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// Crossover operator that combines two strings, cutting them in two random points, interchanging the result
pub fn crossover(random: std.rand.Random, binary_string_1: []u8, binary_string_2: []u8) void {
    var index = random.int(u32) % (binary_string_1.len - 1);
    var len = 1 + random.int(u32) % (binary_string_1.len - index - 1);
    for (index..index + len) |i| {
        const bit: u8 = binary_string_2[i];
        binary_string_2[i] = binary_string_1[i];
        binary_string_1[i] = bit;
    }
}

test "crossover" {
    var prng = try ourRng();
    var allocator = std.testing.allocator;
    const copy_binary_string_1 = try allocator.dupeZ(u8, "1010101");
    defer allocator.free(copy_binary_string_1);

    const copy_binary_string_2 = try allocator.dupeZ(u8, "0101010");
    defer allocator.free(copy_binary_string_2);

    for (0..1000) |_| {
        var binary_string_1 = try allocator.dupeZ(u8, "1010101");
        defer allocator.free(binary_string_1);
        var binary_string_2 = try allocator.dupeZ(u8, "0101010");
        defer allocator.free(binary_string_2);

        crossover(prng.random(), binary_string_1, binary_string_2);

        try expect(copy_binary_string_1.len == binary_string_1.len);
        try expect(copy_binary_string_2.len == binary_string_2.len);

        try expect(!std.mem.eql(u8, copy_binary_string_1, binary_string_1));
        try expect(!std.mem.eql(u8, copy_binary_string_2, binary_string_2));
    }
}
