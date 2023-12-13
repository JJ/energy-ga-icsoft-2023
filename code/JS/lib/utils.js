/**
 *
 * @param { Number} setSize
 * @param { Number} numberOfSets
 * @param { Number} differentElements
 * @returns { Array } an array of different sets
 */
export function generateSets(setSize, numberOfSets, differentElements = 64) {
  let allSets = [];
  for (let i = 0; i < numberOfSets; i++) {
    let thisSet = [];
    for (let j = 0; j < setSize; j++) {
      thisSet = [Math.floor(differentElements * Math.random()), ...thisSet];
    }
    allSets = [...allSets, thisSet];
  }
  return allSets;
}

/**
 *
 * @param {Number} chromosomeSize number of bits in the chromosome
 * @param {Number} numberOfChromosomes number of different chromosomes returned
 * @returns { Array } An array with chromosomes of stated size
 */
export function generateChromosomes(chromosomeSize, numberOfChromosomes) {
  let allChromosomes = [];
  for (let i = 0; i < numberOfChromosomes; i++) {
    let thisChromosome = "";
    for (let j = 0; j < chromosomeSize; j++) {
      thisChromosome = thisChromosome.concat(Math.random() >= 0.5 ? "1" : "0");
    }
    allChromosomes = [...allChromosomes, thisChromosome];
  }
  return allChromosomes;
}

/**
 *
 * @param {String} A chromosome of zeros and ones
 * @returns {Number} number of ones
 */
export function countOnes(chromosome) {
  return chromosome
    .split("")
    .reduce((acc, bit) => acc + (bit === "1" ? 1 : 0), 0);
}

/**
 *
 * @param {String} chrom1 the first one
 * @param {String} chrom2 the other
 * @returns { Array } a pair of resulting chromosomes
 */
export function crossover(chrom1, chrom2) {
  const length = chrom1.length;
  const xover_point = 1 + Math.floor(Math.random() * (length - 1));
  const range = 1 + Math.floor(Math.random() * (length - xover_point));
  let new_chrom1 = chrom1.substring(0, xover_point);
  let new_chrom2 = chrom2.substring(0, xover_point);
  new_chrom1 +=
    chrom2.substring(xover_point, xover_point + range) +
    chrom1.substring(xover_point + range, length);
  new_chrom2 +=
    chrom1.substring(xover_point, xover_point + range) +
    chrom2.substring(xover_point + range, length);
  return [new_chrom1, new_chrom2];
}

/**
 *
 * @param {String} chrom the first
 * @returns { String } Mutated chromosome
 */
export function mutation(chrom) {
  const length = chrom.length;
  const mutation_point = 1 + Math.floor(Math.random() * (length - 1));
  return (
    chrom.substring(0, mutation_point) +
    (chrom[mutation_point] === "0" ? "1" : "0") +
    chrom.substring(mutation_point + 1)
  );
}


function t(a, b) {
  if (a == b) {
    if (a == "0") {
      return "0";
    } else if (a == "1") {
      return "1";
    }
  } else {
    return "-";
  }
}

function T(ev) {
  switch (ev) {
    case "-":
    case "1":
    case "0":
      return ev;
    case "00":
      return "0";
    case "11":
      return "1";
    case "01":
    case "10":
      return "-";
    default:
      if (ev.length == 2 && ev.match(/-/)) return "-";
      else
        return t(
          T(ev.slice(0, ev.length / 2)),
          T(ev.slice(ev.length / 2, ev.length))
        );
  }
}

function f(ev) {
  if (ev == "0" || ev == "1") return 1;
  else return 0;
}

export function HIFF(stringChr) {
    switch (stringChr) {
      case "0":
      case "1":
        return 1;
      case "00":
      case "11":
        return 4;
      case "01":
      case "10":
        return 2;
      default:
        return (
          stringChr.length * f(T(stringChr)) +
          HIFF(stringChr.slice(0, stringChr.length / 2)) +
          HIFF(stringChr.slice(stringChr.length / 2, stringChr.length))
        );
    }
  }