filename =
  IO.gets("File to count the words from: ")
  |> String.trim()

if filename == "h" do
  IO.puts("""
    Usage: [filename] -[flags]
    Flags
    -l    display line count
    -c    display character count
    -w    display word count (default)
    Multiple flags mat be used.
    Example usage:
  
      somefile.txt -lc
  
      Displays line and character count
  
  """)
else
  parts = String.split(filename, "-")
  filename = List.first(parts) |> String.trim()

  flags =
    case(Enum.at(parts, 1)) do
      nil -> ["w"]
      chars -> String.split(chars, "") |> Enum.filter(fn x -> x != "" end)
    end

  body = File.read!(filename)

  lines = String.split(body, ~r{(\r\n|\n|\r)})

  words =
    String.split(body, ~r{(\\n|[^\w'])+})
    |> Enum.filter(fn x -> x != "" end)

  chars = String.split(body, "") |> Enum.filter(fn x -> x != "" end)

  Enum.each(flags, fn flag ->
    case flag do
      "l" -> IO.puts("Lines : #{Enum.count(lines)}")
      "w" -> IO.puts("Words : #{Enum.count(words)}")
      "c" -> IO.puts("Chars : #{Enum.count(chars)}")
    end
  end)
end
