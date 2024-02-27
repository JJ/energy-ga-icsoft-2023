import kotlineo.*

fun main(args : Array<String>) {
    val num_chromosomes = 40000;
    val length = args.getOrElse(0) { "1024" }.toInt();

    var chromosomes = Array(num_chromosomes) { random_chromosome(length) };

    // create an empty array of chromosomes

    var fitness = Array(num_chromosomes) { 0 };

    for (i in 0..num_chromosomes-1){
        // convert the chromosome to a string
        var strChromosome = chromosomes[i].joinToString(separator = "") { if (it) "1" else "0" };
        fitness[i] = hiff(strChromosome);

    }

    println("Generated "+fitness.size+" chromosomes");
    println("Fitness: "+fitness);
}
