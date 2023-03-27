import { equal, ok } from "node:assert";
import { test } from "node:test";
import { generateSets } from "../lib/utils.js";

test("generate test ", () => {
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
