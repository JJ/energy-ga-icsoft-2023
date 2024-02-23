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

    // go over pair of chromosomes in a loop and do crossover and mutation
    var results = std.ArrayList([]const u8).init(allocator);
    var i: usize = 0;
    while (i < chromosomes.len) : (i += 2) {
        const firstChromosome = chromosomes[i].*;
        const secondChromosome = chromosomes[i + 1].*;

        const crossoveredStrings: [2][]const u8 = try crossover(firstChromosome, secondChromosome, &prng, allocator);

        const mutatedString1: []const u8 = try mutation(crossoveredStrings[0], &prng, allocator);
        const mutatedString2: []const u8 = try mutation(crossoveredStrings[1], &prng, allocator);

        try results.append(mutatedString1);
        try results.append(mutatedString2);
    }
}
