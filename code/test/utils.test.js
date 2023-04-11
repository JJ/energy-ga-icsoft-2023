import { equal, ok } from "node:assert";
import { test } from "node:test";
import { countOnes, generateChromosomes, generateSets } from "../lib/utils.js";

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
