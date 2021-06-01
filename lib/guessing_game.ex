defmodule GuessingGame do
  def guess(a, b) when a > b, do: guess(b, a)

  def guess(l, h) do
    response = IO.gets("Hmmm... is it #{mid(l, h)}?\n") |> String.trim()

    case response do
      "bigger" ->
        bigger(l, h)

      "smaller" ->
        smaller(l, h)

      "yes" ->
        "I knew it."

      _ ->
        IO.puts(~s{Type "bigger", "smaller" or "yes"})
        guess(l, h)
    end
  end

  def mid(l, h) do
    div(l + h, 2)
  end

  def bigger(l, h) do
    new_low = min(mid(l, h) + 1, h)
    guess(new_low, h)
  end

  def smaller(l, h) do
    new_high = max(mid(l, h) - 1, l)
    guess(l, new_high)
  end
end
