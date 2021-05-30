defmodule Operator do
  def main do
    IO.inspect(Operator.apply(&MathOperations.square/1, MathOperations.pi()))
    IO.inspect(Operator.apply(fn x, y -> x - y * 2 end, 10, 3))
    IO.inspect(Operator.apply_two(&MathOperations.square/1, &MathOperations.negate/1, 8))
    IO.inspect(Operator.apply_two(&(&1 - &2), fn x -> x * 5 end, 5, 3))
  end

  def apply(operation, data) do
    operation.(data)
  end

  def apply(operation, data1, data2) do
    operation.(data1, data2)
  end

  def apply_two(operation1, operation2, data) do
    result = operation1.(data)
    operation2.(result)
  end

  def apply_two(operation1, operation2, data1, data2) do
    result = operation1.(data1, data2)
    operation2.(result)
  end
end

defmodule MathOperations do
  @pi_val 3.141592653

  def main do
    IO.inspect(add(2, 3))
    IO.inspect(subtract(2, 3))
    IO.inspect(multiply(3, 5))
    IO.inspect(mod(4, 2))
    IO.inspect(area(2))
  end

  def add(x, y), do: x + y
  def subtract(x, y), do: x - y
  def multiply(x, y), do: x * y
  def divide(x, y), do: x / y
  def mod(x, y), do: rem(x, y)
  def negate(x), do: -x
  def square(x), do: x * x
  def pi(), do: @pi_val
  def perimeter(r), do: 2 * pi() * r
  def area(r), do: pi() * square(r)
  def area(x, y), do: multiply(x, y)
end
