defmodule ImportExample do
  # Imports are scoped
  # so imports inside a function are not accessible
  # in another function
  import String, only: [upcase: 1, trim: 1]

  # Module Attribute
  # Only accessible by functions in this module
  @test_file_name "test_file.txt"

  def test_file() do
    @test_file_name
  end

  def do_stuff do
    trim("  string")
  end

  def do_more_stuff do
    upcase("string")
  end

  alias String, as: Bob

  def do_stuff2() do
    Bob.length("Hello")
  end

  def atom_to_string_one(atom) do
    Atom.to_string(atom)
  end

  def atom_to_string_three(atom) do
    alias Atom, as: Waffle
    Waffle.to_string(atom)
  end
end
