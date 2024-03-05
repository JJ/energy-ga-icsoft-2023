package kotlineo

fun random_chromosome(length: Int): BooleanArray {
  return BooleanArray(length) { Math.random() < 0.5 };
}

fun compute_fitness(chromosome: BooleanArray):Int{
  return chromosome.count( { c->c==true } );
}

fun mutate1(chromosome:BooleanArray):BooleanArray{
  val mutation_point = (Math.random() * chromosome.size).toInt();
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

fun f(ev: String): Int {
    return if (ev == "0" || ev == "1") 1 else 0
}

fun t(a: String, b: String): String {
  if (a == b) {
    if (a == "0") {
      return "0"
    } else if (a == "1") {
      return "1"
    }
  }
    return "-"
}

fun T(ev: String): String {
    return when (ev) {
        "-", "1", "0" -> ev
        "00" -> "0"
        "11" -> "1"
        "01", "10" -> "-"
        else -> if (ev.length == 2 && ev.contains("-")) "-"
        else t(T(ev.slice(0 until ev.length / 2)), T(ev.slice(ev.length / 2 until ev.length)))
    }
}

fun hiff(stringChr:String): Int {
  return when (stringChr) {
      "0", "1" -> 1
      "00", "11" -> 4
      "01", "10" -> 2
      else -> stringChr.length * f(T(stringChr)) +
                  hiff(stringChr.slice(0 until stringChr.length / 2)) +
                  hiff(stringChr.slice(stringChr.length / 2 until stringChr.length))
  }
}
