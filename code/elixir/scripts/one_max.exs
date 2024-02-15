# Get chromosome size from sys arg
size = List.first(System.argv(), "1000")

# Generate the population
population = for _ <- 1..1000, do: for(_ <- 1..String.to_integer(size), do: Enum.random(0..1))

# best = Enum.max_by(population, &Enum.sum/1)

IO.write("\rGenerated: " <> size <> " chromosomes\n")
IO.write("First Chromosome:")
IO.inspect(List.first(population))
