const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// Crossover operator that combines two strings, cutting them in two random points, interchanging the result
pub fn boolCrossover(allocator: std.mem.Allocator, random: std.rand.Random, binary_string_1: []bool, binary_string_2: []bool) !void {
    var binary_string_1Clone = try allocator.dupe(bool, binary_string_1);
    defer allocator.free(binary_string_1Clone);
    var binary_string_2Clone = try allocator.dupe(bool, binary_string_2);
    defer allocator.free(binary_string_2Clone);

    var index = random.int(u32) % (binary_string_1.len - 1);
    var len = 1 + random.int(u32) % (binary_string_1.len - index - 1);

    for (index..index + len) |i| {
        binary_string_2[i] = binary_string_1Clone[i];
        binary_string_1[i] = binary_string_2Clone[i];
    }
}

test "crossover" {
    var prng = try ourRng();
    var allocator = std.testing.allocator;

    const copy_binary_string_2 = [_]bool{ false, true, false, true, false, true, false };

    const copy_binary_string_1 = [_]bool{ true, false, true, false, true, false, true };

    for (0..1000) |_| {
        var binary_string_1 = [_]bool{ true, false, true, false, true, false, true };
        var binary_string_2 = [_]bool{ false, true, false, true, false, true, false };
        try boolCrossover(allocator, prng.random(), &binary_string_1, &binary_string_2);

        try expect(copy_binary_string_1.len == binary_string_1.len);
        try expect(copy_binary_string_2.len == binary_string_2.len);

        try expect(!std.mem.eql(bool, &copy_binary_string_1, &binary_string_1));
        try expect(!std.mem.eql(bool, &copy_binary_string_2, &binary_string_2));
    }
}
