const std = @import("std");
const generate = @import("generate.zig").generate;
const utils = @import("utils.zig");

const ourRng = utils.ourRng;
const countOnes = utils.countOnes;
const mutation = utils.mutation;
const crossover = utils.crossover;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const chromosomes = try generate(allocator, &prng, stringLength, numStrings);

    var results = std.ArrayList([]const u8).init(allocator);
    var fitness = std.ArrayList(u32).init(allocator);
    var i: usize = 0;
    while (i < chromosomes.len) : (i += 2) {
        std.debug.print("i: {}\n", .{i});
        const firstChromosome = try allocator.dupeZ(u8, chromosomes[i].*);
        const secondChromosome = try allocator.dupeZ(u8, chromosomes[i + 1].*);

        const crossoveredStrings: [2][]const u8 = try crossover(firstChromosome, secondChromosome, &prng, allocator);

        const mutatedString1: []const u8 = try mutation(crossoveredStrings[0], &prng, allocator);
        const mutatedString2: []const u8 = try mutation(crossoveredStrings[1], &prng, allocator);

        const fitness1 = countOnes(mutatedString1);
        const fitness2 = countOnes(mutatedString2);

        try results.append(mutatedString1);
        try results.append(mutatedString2);
        try fitness.append(fitness1);
        try fitness.append(fitness2);
    }
    std.debug.print("Results: {}\n", .{results.items.len});
}
