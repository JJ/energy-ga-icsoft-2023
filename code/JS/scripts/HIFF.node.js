import { hashify } from "saco-js";
import { HIFF, generateChromosomes } from "../lib/utils.js";

const size = process.argv[2];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const start = Date.now();
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
const endGeneration = Date.now();
console.warn("Time so far ", endGeneration - start);

const fitnessArray = [];
population.forEach((c) => {
  fitnessArray.push(HIFF(c));
});
console.warn("Time so far ", Date.now() - endGeneration);

console.log(hashify(fitnessArray));
