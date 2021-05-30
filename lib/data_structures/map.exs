defmodule MapExample do
  def main do
    # Go to key-value data structure
    a = Map.new()
    a = %{"one" => :two, 3 => "four"}
    b = %{one: "1", two: "2"}
    # the : syntax uses atoms as keys
    IO.inspect(a["one"])
    IO.inspect(b.one)

    # Functions

    IO.inspect(Map.get(%{a: 1}, :a))

    IO.inspect(
      Map.get_and_update!(%{a: 1}, :a, fn current_value ->
        {current_value, "new value!"}
      end)
    )

    IO.inspect(Map.delete(%{a: 1, b: 2}, :a))

    IO.inspect(Map.drop(%{a: 1, b: 2, c: 3}, [:b, :d]))

    IO.inspect(Map.equal?(%{a: 1, b: 2}, %{b: 2, a: 1}))
    # Comparison is ===/3 so 1 & 1.0 are not equal

    IO.inspect(Map.to_list(%{a: 1}))
  end
end
