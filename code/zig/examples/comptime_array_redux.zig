const std = @import("std");

pub fn main() void {
    const point_letters = [10][]const u8{ "AEIOULNRST", "DG", "BCMP", "FHVWY", "K", "", "", "JX", "", "QZ" };
    std.debug.print("Point_letters = {s}\n", .{point_letters[0]});
}
