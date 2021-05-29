defmodule IntegerExample do
  def main do
    a = 10
    b = 11

    # Guards
    IO.inspect(Integer.is_even(a))

    IO.inspect(Integer.is_odd(b))

    # Functions

    IO.inspect(Integer.digits(123))
    # [1, 2, 3]

    IO.inspect(Integer.undigits([1, 2, 3]))
    # 123

    IO.inspect(Integer.extended_gcd(240, 46))
    # {2, -9, 47}

    IO.inspect(Integer.gcd(2, 3))
    # 1

    IO.inspect(Integer.floor_div(5, 2))
    # 2

    IO.inspect(Integer.mod(5, 2))
    # 1

    IO.inspect(Integer.parse("5.2"))
    # {5, ".2"}

    IO.inspect(Integer.to_charlist(5))
    # '5'

    IO.inspect(Integer.to_string(5))
    # '5'

    IO.inspect(Integer.pow(2, 3))
    # 8
  end
end
