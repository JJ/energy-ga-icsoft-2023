const std = @import("std");

pub fn build(b: *std.build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const tests = b.addTest(.{
        .root_source_file = .{ .path = "src/my_library.zig" },
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run library tests");
    const run_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_tests.step);

    const exe = b.addExecutable(.{
        .name = "chromosome_generator",
        .root_source_file = .{ .path = "src/chromosome_generator.zig" },
        .target = target,
        .optimize = optimize,
        .single_threaded = true,
    });

    b.installArtifact(exe);
}
