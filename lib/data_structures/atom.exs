defmodule AtomExample do
  def main do
    IO.inspect(:ok)

    # true == :true

    IO.inspect(:"An atom")

    IO.inspect(is_atom(:ok))

    # Functions
    IO.inspect(Atom.to_charlist(:"An atom"))

    IO.inspect(Atom.to_string(:foo))
  end
end
