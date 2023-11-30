package kotlineo


fun random_chromosome(length: Int): BooleanArray {
  var new_chromosome = BooleanArray(length, {false});

  for(i in 0..length-1){
    new_chromosome[i] = Math.random() < 0.5;
  }
  return new_chromosome;
}


fun compute_fitness(chromosome: BooleanArray):Int{
  return chromosome.count( { c->c==true } );
}


fun mutate1(chromosome:BooleanArray):BooleanArray{
  var mutation_point = (Math.random() * chromosome.size).toInt();
  var mutie = chromosome.clone();

  mutie[mutation_point]= mutie[mutation_point].not();
  return mutie;

}


fun crossover(chromosome1: BooleanArray, chromosome2:BooleanArray): Array<BooleanArray>{
  var length = chromosome1.size
  var xover_point = (Math.random() * chromosome1.size).toInt();
  var scope = 1 +  (Math.random() * (length - xover_point)).toInt();

  var new_chromo1=BooleanArray(length,{false});
  var new_chromo2=BooleanArray(length,{false});

  for(i in 0..xover_point-1){
    new_chromo1[i]=chromosome1[i];
    new_chromo2[i]=chromosome2[i];
  }
  for(i in xover_point..xover_point+scope-1){
    new_chromo1[i]=chromosome2[i];
    new_chromo2[i]=chromosome1[i];
  }
  for(i in xover_point+scope..length-1){
    new_chromo1[i]=chromosome1[i];
    new_chromo2[i]=chromosome2[i];
  }

  var result =  Array<BooleanArray>(2,{BooleanArray(0,{false})});
  result[0]=new_chromo1;
  result[1]=new_chromo2;
  return result;
}


fun draw(chromosome:BooleanArray){
  for (i in chromosome.indices){
    if(chromosome[i]){
      print(1);
    }
    else{
      print(0);
    }
  }
  println();
  return;
}
