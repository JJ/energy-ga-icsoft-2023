import kotlineo.*

fun main(args : Array<String>) {
    var num_chromosomes = 40000;
    var length = args.getOrElse(0) { "1024" }.toInt();

    var chromosomes = Array(num_chromosomes, {random_chromosome(length)});

    println("Generated "+chromosomes.size+" chromosomes");
    println( "First chromosome: " + draw(chromosomes[0]) );
}
