const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// Crossover operator that combines two strings, cutting them in two random points, interchanging the result
pub fn crossover(allocator: std.mem.Allocator, random: std.rand.Random, binary_string_1: []u8, binary_string_2: []u8) !void {
    var binary_string_1Clone = try allocator.dupeZ(u8, binary_string_1);
    defer allocator.free(binary_string_1Clone);
    var binary_string_2Clone = try allocator.dupeZ(u8, binary_string_2);
    defer allocator.free(binary_string_2Clone);

    var index = random.int(u32) % (binary_string_1.len - 1);
    var len = 1 + random.int(u32) % (binary_string_1.len - index - 1);
    std.debug.print("index: {d}, len: {d}\n", .{ index, len });
    for (index..index + len) |i| {
        std.debug.print("i: {d}\n", .{i});
        binary_string_2[i] = binary_string_1Clone[i];
        binary_string_1[i] = binary_string_2Clone[i];
    }
}

test "crossover" {
    var prng = try ourRng();
    var allocator = std.testing.allocator;

    var binary_string_2 = try allocator.dupeZ(u8, "0101010");
    defer allocator.free(binary_string_2);
    const copy_binary_string_2 = try allocator.dupeZ(u8, "0101010");
    defer allocator.free(copy_binary_string_2);

    for (0..1000) |_| {
        var binary_string_1 = try allocator.dupeZ(u8, "1010101");
        defer allocator.free(binary_string_1);
        const copy_binary_string_1 = try allocator.dupeZ(u8, "1010101");
        defer allocator.free(copy_binary_string_1);
        try crossover(allocator, prng.random(), binary_string_1, binary_string_2);

        try expect(copy_binary_string_1.len == binary_string_1.len);
        try expect(copy_binary_string_2.len == binary_string_2.len);
        std.debug.print("binary_string_1: {s}\n", .{binary_string_1});
        std.debug.print("binary_string_2: {s}\n", .{binary_string_2});

        try expect(!std.mem.eql(u8, copy_binary_string_1, binary_string_1));
        try expect(!std.mem.eql(u8, copy_binary_string_2, binary_string_2));
    }
}
