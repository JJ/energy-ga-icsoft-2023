import { generateChromosomes } from "../lib/utils.js";

const size = process.argv[2] || 512;
const NUMBER_OF_CHROMOSOMES = 40000;

console.log("Size ", size);
const allChromosomes = generateChromosomes(size, NUMBER_OF_CHROMOSOMES);
console.log("Generated ", allChromosomes.length, " chromosomes");
