defmodule ListExample do
  def main do
    # Linked List
    # Accessing - Linear
    a = [1, "two", 3, :four]
    # slow
    b = [1, 2, 3] ++ [4, 5, 6]
    c = 0
    # fast
    list = [c | a]
    [head | tail] = [1, 2, 3]
    IO.puts(head)

    # Functions
  end
end
