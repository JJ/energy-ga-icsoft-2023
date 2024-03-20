const std = @import("std");
const expect = std.testing.expect;
const ourRng = @import("utils.zig").ourRng;

// MaxOnes or CountOnes implementation
pub inline fn countOnes(binaryString: []const u8) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += if (binaryChar == '1') 1 else 0;
    }
    return count;
}

pub inline fn boolCountOnes(binaryString: []const bool) u32 {
    var count: u32 = 0;
    for (binaryString) |binaryChar| {
        count += if (binaryChar == true) 1 else 0;
    }
    return count;
}

test "countOnes" {
    var binaryString: []const u8 = "101010";
    try expect(countOnes(binaryString) == 3);
}

test "boolCountOnes" {
    var binaryString = [_]bool{ true, false, true, false, true, false };
    try expect(boolCountOnes(&binaryString) == 3);
}
