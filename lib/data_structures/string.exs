defmodule StringExample do
  def main do
    # "" ->String, '' -> charlist
    a = "hello"
    b = a <> " " <> "world!"

    IO.inspect("String: #{b}")

    IO.inspect("2 + 2: #{2 + 2}")

    IO.inspect(String.length(b))

    c = "Mr. John"
    IO.inspect(String.slice(c, 3, String.length(c) - 3))

    # Functions

    IO.inspect(String.at("elixir", 0))

    IO.inspect(String.upcase("elixir"))

    IO.inspect(String.downcase("elixir"))

    IO.inspect(String.capitalize("elixir"))

    IO.inspect(String.contains?("elixir", "el"))

    IO.inspect(String.duplicate("abc", 3))
    # "abcabcabc"

    IO.inspect(String.ends_with?("language", ["youth", "age"]))

    IO.inspect(String.pad_leading("abc", 5))
    # "  abc"

    IO.inspect(String.pad_trailing("abc", 5))
    # "abc  "

    IO.inspect(String.replace("abc", "a", "-"))

    IO.inspect(String.reverse("abc"))

    IO.inspect(String.slice("elixir", 1..4))

    IO.inspect(String.trim("   elixir "))

    IO.inspect(String.split("foo bar", " "))

    IO.inspect(String.split_at("sweetelixir", 5))

    IO.inspect(String.to_atom("sweetelixir"))
  end
end
