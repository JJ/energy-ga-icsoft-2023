import kotlineo.*

fun calculeTime(length:Int, iterations:Int):Float{
  var timestart = System.nanoTime();



  for (i in 0..iterations-1){
    var indi =  random_chromosome(length)
    compute_fitness( indi )
  }

  var timeend = System.nanoTime();
  var estimated = (timeend - timestart).toFloat()/1000000000.toFloat();

  return estimated.toFloat();
}



fun main() {
  var length = 16;
  var iterations = 100000;
  var top_length = 32768;

  while(length<top_length){
    println("Kotlin-BitVector, "+length.toString()+", "+calculeTime(length,iterations));
    length*=2;
  }
}
