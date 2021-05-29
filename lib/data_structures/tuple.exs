defmodule TupleExample do
  def main do
    # Contigously Stored
    # Accessing - Constant
    # Modifying - Linear
    a = {1, :two, "three"}

    # Functions
    tuple = {:foo, :bar}
    IO.inspect(Tuple.append(tuple, :baz))

    IO.inspect(Tuple.delete_at(tuple, 0))

    # Avoid
    result = Tuple.insert_at(a, 2, :ok)
    # Preferred
    {hd, atom} = tuple
    result = {hd, :ok, atom}

    IO.inspect(Tuple.product({255, 255}))

    IO.inspect(Tuple.sum({255, 255}))

    IO.inspect(Tuple.to_list(tuple)))

  end
end
