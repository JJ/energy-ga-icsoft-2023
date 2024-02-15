defmodule Genetic do
  def crossover_ind(p1, p2) do
    cx_point = :rand.uniform(length(p1))
    {{h1, t1}, {h2, t2}} = {Enum.split(p1, cx_point), Enum.split(p2, cx_point)}
    {h1 ++ t2, h2 ++ t1}
  end

  # Move to another module
  def calculate(p1, p2, iterations) do
    prev = System.monotonic_time()
    for _ <- 1..iterations, do: crossover_ind(p1, p2)
    next = System.monotonic_time()
    (next - prev) / 1_000_000_000
  end

  def iterate(length, top_length, iterations) when length <= top_length do
    p1 = for _ <- 1..length, do: Enum.random(0..1)
    p2 = for _ <- 1..length, do: Enum.random(0..1)
    time = calculate(p1, p2, iterations)

    IO.puts("Elixir List, #{length}, #{time}")

    IO.inspect(time)
    iterate(length * 2, top_length, iterations)
  end

  def iterate(_, _, _) do
  end
end

Crossover.iterate(16, 32768, 100_000)
