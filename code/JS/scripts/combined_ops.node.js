#!/home/jmerelo/.bun/bin/bun

import { mutation, crossover, countOnes, generateChromosomes } from "../lib/utils.js";

const size = process.argv[2] || 512;
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
const pairs = [];
const HALF_POPULATION = NUMBER_OF_CHROMOSOMES / 2;
for (let i = 0; i < HALF_POPULATION; i++) {
  pairs.push([population[i], population[i + HALF_POPULATION]]);
}

const newGeneration = [];
pairs.forEach((pair) => {
    const crossed_pair = crossover(pair[0], pair[1]);
    for (let x in crossed_pair) {
        const mutated = mutation(crossed_pair[x]);
        newGeneration.push([ mutated, countOnes(mutated) ] );
    }
});

console.log(newGeneration.length, "chromosomes generated");
