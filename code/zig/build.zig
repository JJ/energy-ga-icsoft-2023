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
        .optimize = .ReleaseFast,
        .single_threaded = true,
    });

    b.installArtifact(exe);

    const combined_ops = b.addExecutable(.{
        .name = "combined_ops",
        .root_source_file = .{ .path = "src/combined_ops.zig" },
        .target = target,
        .optimize = .ReleaseFast,
        .single_threaded = true,
    });

    b.installArtifact(combined_ops);

    const hiff = b.addExecutable(.{
        .name = "run_hiff",
        .root_source_file = .{ .path = "src/run_hiff.zig" },
        .target = target,
        .optimize = .ReleaseFast,
        .single_threaded = true,
    });

    b.installArtifact(hiff);
}
