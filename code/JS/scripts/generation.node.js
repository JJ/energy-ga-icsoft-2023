import { countOnes, crossover, generateChromosomes, mutation } from "../lib/utils.js";

const size = process.argv[2];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const start = Date.now();
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
const endGeneration = Date.now();
console.warn("Time so far ", endGeneration - start);
const pairs = [];
const HALF_POPULATION = NUMBER_OF_CHROMOSOMES / 2;
const selected = [];
for (let i = 0; i < HALF_POPULATION; i++) {
  if (countOnes(population[i]) > countOnes(population[i + HALF_POPULATION])) {
    selected.push(population[i]);
  } else {
    selected.push(population[i + HALF_POPULATION]);
  }
}

// create random pairs of chromosomes in the selected array eliminating those that have already been paired
while (selected.length > 0) {
  const first = Math.floor(Math.random() * selected.length);
  const firstChrom = selected[first];
  selected.splice(first, 1);
  const second = Math.floor(Math.random() * selected.length);
  const secondChrom = selected[second];
  selected.splice(second, 1);
  pairs.push([firstChrom, secondChrom]);
}

const newGeneration = [];
pairs.forEach((pair) => {
  const newPair = crossover(pair[0], pair[1]);
  newGeneration.push( mutation(newPair[0]));
  newGeneration.push( mutation(newPair[1]));
});
console.warn("Time so far ", Date.now() - endGeneration);

