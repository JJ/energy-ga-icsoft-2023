const std = @import("std");
const expect = std.testing.expect;

// function that generates a string array
pub fn generate(allocator: std.mem.Allocator, stringLength: u16, numStrings: u32) ![]*const []u8 {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });

    var stringArray: []*const []u8 = try allocator.alloc(*const []u8, numStrings);

    var i: u32 = 0;
    while (i < numStrings) {
        var binaryString = try allocator.alloc(u8, stringLength);

        var c: u32 = 0;
        while (c < stringLength) : (c += 1) {
            binaryString[c] = prng.random().intRangeAtMost(u8, '0', '1');
        }

        // add the new string to stringArray
        stringArray[i] = &binaryString;
        i = i + 1;
    }
    return stringArray;
}

// test the function
test "generate" {
    const stringLength: u16 = 10;
    const numStrings: u32 = 10;
    const allocator = std.heap.page_allocator;
    const stringArray = try generate(allocator, stringLength, numStrings);
    try expect(stringArray[0].len == stringLength);
    try expect(stringArray[numStrings - 1].len == stringLength);
    // loop through all strings in StringArray to check that every element is either 1 or 0
    var i: u32 = 0;
    while (i < numStrings) {
        var c: u16 = 0;
        while (c < stringLength) : (c += 1) {
            try expect(stringArray[i].*[c] == '0' or stringArray[i].*[c] == '1');
        }
        i = i + 1;
    }
}
