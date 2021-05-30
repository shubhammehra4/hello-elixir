defmodule FunctionExample do
  def do_something do
    "something"
  end

  def sum(a, b \\ 5) do
    a + b
  end

  def echo(p) do
    p
  end

  def subtract(a, b), do: a - b

  def main do
    add2 = fn x, y -> x + y end
    IO.inspect(add2.(2, 3))

    hello = fn -> "hello" end
    IO.inspect(hello.())

    add = &(&1 + &2)
    IO.inspect(add.(2, 3))

    create_tuple = &{&1, &2}
    IO.inspect(create_tuple.(2, 3))

    create_list = &[&1, &2]
    IO.inspect(create_list.(2, 3))
  end

  def do_more(a, b \\ 1, c, d) do
    IO.inspect(private_stuff())
    [a, b, c, d]
  end

  defp private_stuff do
    "Private"
  end
end
