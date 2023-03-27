import { hashify, sacoUnion } from "saco-js";
import { generateSets } from "../lib/utils.js";

const size = process.argv[2];
const NUMBER_OF_SETS = 1024;

const sacos = generateSets(size, NUMBER_OF_SETS).map((s) => hashify(s));

let merged = sacos;
do {
  merged = pairUnion(merged);
} while (merged.length > 1);
console.log(merged);

function pairUnion(sacos) {
  const byPairs = sacos.flatMap((_, i, a) =>
    i % 2 ? [] : [a.slice(i, i + 2)]
  );
  return byPairs.map((p) => sacoUnion(p[0], p[1]));
}
