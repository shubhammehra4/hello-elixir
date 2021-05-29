defmodule ListExample do
  def main do
    # Linked List
    # Accessing - Linear
    a = [1, "two", 3, :four]
    # slow
    b = [1, 2, 3] ++ [4, 5, 6]
    c = 1
    # fast
    b = [c | a]

    improper_list = [1, 2 | 3]

    [head | tail] = [1, 2, 3]
    IO.puts(head)
    # 1

    # Functions
    IO.inspect(List.insert_at([1, 2, 3, 4], 2, 0))

    IO.inspect(List.delete([:a, :b, :c], :a))

    IO.inspect(List.delete_at([:a, :b, :c], 0))

    IO.inspect(List.duplicate("bye", 3))
    # ["bye", "bye", "bye"]

    IO.inspect(List.flatten([1, [[2], 3]]))
    # [1, 2, 3]

    IO.inspect(List.foldl([5, 5], 0, fn x, acc -> x + acc end))
    # 10
    # Reduces the List from start

    IO.inspect(List.foldr([1, 2, 3, 4], 0, fn x, acc -> x - acc end))
    # -2
    # Reduces the List from end

    IO.inspect(List.improper?([1, 2 | 3]))

    IO.inspect(List.to_tuple([:share, [:elixir, 163]]))
  end
end
