import { mutation, generateChromosomes } from "../lib/utils.js";

const size = Deno.args[0];
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const population = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);

const newPopulation = [];
population.forEach((chrom) => {
  newPopulation.push(mutation(chrom));
});

console.log(newPopulation);
