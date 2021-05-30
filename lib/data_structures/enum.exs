defmodule EnumExample do
  def main do
    # Set of algorithms to work with enumerables/iterable

    IO.inspect(Enum.map([1, 2, 3], fn x -> x * 2 end))

    IO.inspect(Enum.sum(1..4))

    IO.inspect(Enum.concat([1..3, 4..6, 7..9]))

    IO.inspect(Enum.count([1, 2, 3]))
  end
end
