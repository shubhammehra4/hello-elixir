defmodule TodoList do
  def start do
    IO.gets("Name of .csv to load: ")
    |> String.trim()
    |> read()
    |> parse()
    |> get_command()
  end

  def get_command(data) do
    prompt = """
    Type the first letter of the command you want to run
      R - Read Todos
      A - Add a Todo
      D - Delte a Todo
      L - Load a .csv
      S - Save a .csv
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> show_todos(data)
      "d" -> delete_todos(data)
      "q" -> "Goodbye!"
      _ -> get_command(data)
    end
  end

  def read(filename) do
    case(File.read(filename)) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s{An error happened while openning "#{filename}"\n})
        IO.inspect(~s{":file.format_error(#{reason})"})
        start()
        ""
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\n|\r)})
    titles = tl(String.split(header, ","))
    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, acc ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data =
          Enum.zip(titles, fields)
          |> Enum.into(%{})

        Map.merge(acc, %{name => line_data})
      else
        acc
      end
    end)
  end

  def show_todos(data, next_command? \\ true) do
    IO.puts("You have the following Todos:\n")

    Map.keys(data)
    |> Enum.each(fn item -> IO.puts(item) end)

    IO.puts("\n")

    if next_command? do
      get_command(data)
    end
  end

  def delete_todos(data) do
    todo =
      IO.gets("Which Todo would you like to delete?\n")
      |> String.trim()

    if Map.has_key?(dat, todo) do
      new = Map.drop(data, [todo])
      IO.puts("Done")
      get_command(new)
    else
      IO.puts(~s{There is no Todo named "#{todo}"})
      show_todos(data, false)
    end
  end
end
