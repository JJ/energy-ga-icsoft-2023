import { hashify } from "https://deno.land/x/saco@v0.0.2/index.js";
import { countOnes, generateChromosomes } from "../lib/utils.js";

const size = Deno.args[0];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);

const fitnessArray = [];
population.forEach((c) => {
  fitnessArray.push(countOnes(c));
});

console.log(hashify(fitnessArray));
