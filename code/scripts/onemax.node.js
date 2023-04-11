import { hashify } from "saco-js";
import { countOnes, generateChromosomes } from "../lib/utils.js";

const size = process.argv[2];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);

const fitnessArray = [];
population.forEach((c) => {
  fitnessArray.push(countOnes(c));
});

console.log(hashify(fitnessArray));
