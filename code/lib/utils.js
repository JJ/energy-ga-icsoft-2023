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
