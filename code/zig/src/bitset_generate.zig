const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// function that generates a string array
pub fn generate(allocator: std.mem.Allocator, random: std.rand.Random, comptime T: type, num_strings: u32) ![]T {
    var bitField = try allocator.alloc(T, num_strings);
    for (0..num_strings) |i| {
        bitField[i] = T.initEmpty();
        for (0..bitField[i].capacity()) |j| {
            if (random.intRangeAtMost(u8, 0, 1) == 1) {
                bitField[i].set(j);
            }
        }
    }
    return bitField;
}

// test the function
test "generate" {
    const stringLength: u16 = 10;
    const numStrings: u32 = 10;
    const allocator = std.heap.page_allocator;
    var prng = try ourRng();
    const bitFieldArray = try generate(allocator, prng.random(), std.bit_set.StaticBitSet(stringLength), numStrings);
    try expect(bitFieldArray[0].capacity() == stringLength);
    try expect(bitFieldArray[numStrings - 1].capacity() == stringLength);
    var i: u32 = 0;
    while (i < numStrings) {
        var c: u16 = 0;
        while (c < stringLength) : (c += 1) {
            try expect(bitFieldArray[i].isSet(c) or !bitFieldArray[i].isSet(c));
        }
        i = i + 1;
    }

    allocator.free(bitFieldArray);
}
