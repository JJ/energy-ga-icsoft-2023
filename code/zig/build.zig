const std = @import("std");

pub fn build(b: *std.build) void {
    const tests = b.addTest("src/my_library.zig");
    tests.setBuildMode(.Debug);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(tests);

    const target = b.Builder.standardTargetOptions(.{});
    const optimize = b.Builder.standardOptimizeOption(.{});

    const exe = b.Builder.addExecutable(.{
        .name = "onemax",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
        .single_threaded = true,
    });

    b.installArtifact(exe);
}
