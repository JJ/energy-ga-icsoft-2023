import kotlineo.*

fun main(args : Array<String>) {
    val num_chromosomes = 40000;
    val length = args.getOrElse(0) { "1024" }.toInt();

    var chromosomes = Array(num_chromosomes) { random_chromosome(length) };

    // create an empty array of chromosomes
    var new_chromosomes = Array(num_chromosomes) { BooleanArray(0) };
    var fitness = Array(num_chromosomes) { 0 };

    for (i in 0..num_chromosomes-1 step 2){
        var crossed_pair = crossover(chromosomes[i], chromosomes[i+1]);
        new_chromosomes[i] = mutate1(crossed_pair[0]);
        new_chromosomes[i+1] = mutate1(crossed_pair[1]);
        fitness[i] = compute_fitness(new_chromosomes[i]);
        fitness[i+1] = compute_fitness(new_chromosomes[i+1]);
    }

    println("Generated "+new_chromosomes.size+" chromosomes");
    println( "Fitness" + fitness.joinToString(",") );
}
