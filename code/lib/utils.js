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
 * @param {String} chrom1 the first
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
