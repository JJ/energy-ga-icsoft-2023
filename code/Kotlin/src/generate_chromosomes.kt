import kotlineo.*

fun main(args : Array<String>) {
    val num_chromosomes = 40000;
    val length = args.getOrElse(0) { "1024" }.toInt();

    var chromosomes = Array(num_chromosomes) { random_chromosome(length) };

    println("HIFF first try: " + hiff("00"));
    println("Generated "+chromosomes.size+" chromosomes");
    println( "First chromosome: " + draw(chromosomes[0]) );
}
