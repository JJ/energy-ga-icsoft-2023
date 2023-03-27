import { hashify, sacoUnion } from "saco-js";
import { generateSets } from "../lib/utils.js";

const size = process.argv[2];
console.log(size);
const NUMBER_OF_SETS = 1024;

const sacos = generateSets(size, NUMBER_OF_SETS).map((s) => hashify(s));

console.log(sacos);
