const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// function that generates a string array
pub fn generate(allocator: std.mem.Allocator, random: std.rand.Random, string_length: u16, num_strings: u32) ![][]u8 {
    var stringArray = try allocator.alloc([]u8, num_strings);
    for (0..num_strings) |i| {
        stringArray[i] = try allocator.alloc(u8, string_length);
        for (0..string_length) |j| {
            stringArray[i][j] = random.intRangeAtMost(u8, '0', '1');
        }
    }
    return stringArray;
}

// test the function
test "generate" {
    const stringLength: u16 = 10;
    const numStrings: u32 = 10;
    const allocator = std.heap.page_allocator;
    var prng = try ourRng();
    const stringArray = try generate(allocator, prng.random(), stringLength, numStrings);
    try expect(stringArray[0].len == stringLength);
    try expect(stringArray[numStrings - 1].len == stringLength);
    // loop through all strings in StringArray to check that every element is either 1 or 0
    var i: u32 = 0;
    while (i < numStrings) {
        var c: u16 = 0;
        while (c < stringLength) : (c += 1) {
            try expect(stringArray[i][c] == '0' or stringArray[i][c] == '1');
        }
        i = i + 1;
    }

    for (stringArray) |string| {
        allocator.free(string);
    }
    allocator.free(stringArray);
}
