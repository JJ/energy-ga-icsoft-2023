import { equal, ok } from "node:assert";
import { test } from "node:test";
import { hashify } from "saco-js";
import {
  countOnes,
  crossover,
  generateChromosomes,
  generateSets,
  mutation,
} from "../lib/utils.js";

test("generate sets", () => {
  [8, 64].forEach((size) => {
    const first = generateSets(size, size);
    equal(first.length, size);
    equal(first[0].length, size);
    const second = generateSets(size, size, size);
    second[0].forEach((e) => {
      ok(e < size);
      ok(e >= 0);
    });
  });
});

test("generate chromosomes ", () => {
  [8, 64].forEach((size) => {
    const first = generateChromosomes(size, size);
    equal(first.length, size);
    first.forEach((e) => {
      equal(e.length, size);
      ok(e.match(/^[01]+$/));
    });
  });
});

test("Onemax ", () => {
  equal(countOnes("1"), 1);
  equal(countOnes("10000000000000000000000000000000000"), 1);
  equal(countOnes("100000000000000000000000000000000001"), 2);
  equal(countOnes("0000000000000000000000000000000000"), 0);
});

test("Crossover ", () => {
  const chrom1 = "000000000000";
  const chrom2 = "111111111111";
  const [newChrom1, newChrom2] = crossover(chrom1, chrom2);
  const hash1 = hashify(newChrom1.split(""));
  const hash2 = hashify(newChrom2.split(""));
  equal(hash1["0"], hash2["1"]);
  equal(hash1["1"], hash2["0"]);
});

test("Mutation ", () => {
  const chrom = "000000000000";
  const newChrom = mutation(chrom);
  const hash = hashify(newChrom.split(""));
  equal(hash["0"], chrom.length - 1);
  equal(hash["1"], 1);
});
