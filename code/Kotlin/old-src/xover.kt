import kotlineo.*

fun calculeTime(chromosome1:BooleanArray, chromosome2:BooleanArray, iterations:Int):Float{
  var timestart = System.nanoTime();

  for (i in 0..iterations-1){
    crossover( chromosome1, chromosome2 );
  }

  var timeend = System.nanoTime();
  var estimated = (timeend - timestart).toFloat()/1000000000.toFloat();

  return estimated.toFloat();
}



fun main(args : Array<String>) {
  var length = 16;
  var iterations = 100000;
  var top_length = 32768;

  while(length<top_length){
    var indi =  random_chromosome(length)
    var indi2 =  random_chromosome(length)
    println("Kotlin-BitVector, "+length.toString()+", "+calculeTime(indi,indi2,iterations));
    length*=2;
  }
}
