const std = @import("std");
const generate = @import("generate.zig").generate;

const ourRng = @import("utils.zig").ourRng;
const countOnes = @import("count_ones.zig").countOnes;
const mutation = @import("mutation.zig").mutation;
const crossover = @import("crossover.zig").crossover;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var prng: std.rand.DefaultPrng = try ourRng();

    var argsIterator = try std.process.argsWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next(); // First argument is the program name

    const stringLenArg = argsIterator.next() orelse "512";
    const stringLength = try std.fmt.parseInt(u16, stringLenArg, 10);

    const numStrings = 40000;

    const chromosomes = try generate(allocator, prng.random(), stringLength, numStrings);

    var results = std.ArrayList([]const u8).init(allocator);
    var fitness = std.ArrayList(u32).init(allocator);
    var i: usize = 0;
    while (i < chromosomes.len) : (i += 2) {
        const firstChromosome = try allocator.dupeZ(u8, chromosomes[i]);
        const secondChromosome = try allocator.dupeZ(u8, chromosomes[i + 1]);

        try crossover(allocator, prng.random(), firstChromosome, secondChromosome);

        mutation(firstChromosome, prng.random());
        mutation(secondChromosome, prng.random());

        const fitness1 = countOnes(firstChromosome);
        const fitness2 = countOnes(secondChromosome);

        try results.append(firstChromosome);
        try results.append(secondChromosome);
        try fitness.append(fitness1);
        try fitness.append(fitness2);
    }
    std.debug.print("Results: {}\n", .{results.items.len});
}
