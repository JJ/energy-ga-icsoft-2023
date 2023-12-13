import { crossover, generateChromosomes, mutation } from "../lib/utils.js";

const size = process.argv[2];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const start = Date.now();
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
const endGeneration = Date.now();
console.warn("Time so far ", endGeneration - start);
const pairs = [];
const HALF_POPULATION = NUMBER_OF_CHROMOSOMES / 2;
for (let i = 0; i < HALF_POPULATION; i++) {
  pairs.push([population[i], population[i + HALF_POPULATION]]);
}

const newPairs = [];
pairs.forEach((pair) => {
  const newPair = crossover(pair[0], pair[1]);
  newPairs.push( [ mutation(newPair[0]), mutation(newPair[1]) ] );
});
console.warn("Time so far ", Date.now() - endGeneration);

