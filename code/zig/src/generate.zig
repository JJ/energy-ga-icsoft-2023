const std = @import("std");

// function that generates a string array
pub fn generate(stringLength: u16, numStrings: u32) ![]u8 {
    const allocator = std.heap.page_allocator;

    var i: u32 = 0;
    const RndGen = std.rand.DefaultPrng;
    var rnd = RndGen.init();

    // Declare empty array to store the strings
    var stringArray: []u8 = undefined;

    while (i < numStrings) {
        i = i + 1;
        var binaryString = try allocator.alloc(u8, stringLength);

        var c: u32 = 0;
        while (c < stringLength) : (c += 1) {
            binaryString[c] = rnd.random().intRangeAtMost(u8, 0, 1);
        }

        // add the new string to stringArray
        stringArray = stringArray ++ binaryString;
    }
    return stringArray;
}
