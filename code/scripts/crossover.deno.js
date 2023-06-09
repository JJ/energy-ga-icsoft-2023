import { crossover, generateChromosomes } from "../lib/utils.js";

const size = Deno.args[0];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
const pairs = [];

const HALF_POPULATION = NUMBER_OF_CHROMOSOMES / 2;
for (let i = 0; i < HALF_POPULATION; i++) {
  pairs.push([population[i], population[i + HALF_POPULATION]]);
}

console.log(pairs);
const newPairs = [];
pairs.forEach((pair) => {
  newPairs.push(crossover(pair[0], pair[1]));
});

console.log(newPairs);
