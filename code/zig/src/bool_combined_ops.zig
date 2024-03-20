const std = @import("std");
const boolGenerate = @import("bool_generate.zig").boolGenerate;

const ourRng = @import("utils.zig").ourRng;
const boolCountOnes = @import("count_ones.zig").boolCountOnes;
const boolMutation = @import("bool_mutation.zig").boolMutation;
const boolCrossover = @import("bool_crossover.zig").boolCrossover;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const chromosomes = try boolGenerate(allocator, prng.random(), stringLength, numStrings);

    var results = std.ArrayList([]const bool).init(allocator);
    var fitness = std.ArrayList(u32).init(allocator);
    var i: usize = 0;
    while (i < chromosomes.len) : (i += 2) {
        const firstChromosome = try allocator.dupe(bool, chromosomes[i]);
        const secondChromosome = try allocator.dupe(bool, chromosomes[i + 1]);

        boolCrossover(prng.random(), firstChromosome, secondChromosome);

        boolMutation(firstChromosome, prng.random());
        boolMutation(secondChromosome, prng.random());

        const fitness1 = boolCountOnes(firstChromosome);
        const fitness2 = boolCountOnes(secondChromosome);

        try results.append(firstChromosome);
        try results.append(secondChromosome);
        try fitness.append(fitness1);
        try fitness.append(fitness2);
    }
    std.debug.print("Results: {}\n", .{results.items.len});
}
