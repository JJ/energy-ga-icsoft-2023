import { hashify, sacoUnion } from "https://deno.land/x/saco@v0.0.2/index.js";
import { generateSets } from "../lib/utils.js";

const size = Deno.args[0];
const NUMBER_OF_SETS = 1024;

console.log( "Size ", size);
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
