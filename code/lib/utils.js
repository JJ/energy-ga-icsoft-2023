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
