defmodule TodoList do
  def start do
    load_csv()
  end

  def get_command(data) do
    prompt = """
      Type the first letter of the command you want to run
          r - Read Todos
          a - Add a Todo
          d - Delte a Todo
          l - Load a .csv
          s - Save a .csv
          q - Quit
    
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> show_todos(data)
      "a" -> add_todo(data)
      "d" -> delete_todos(data)
      "l" -> load_csv()
      "s" -> save_csv(data)
      "q" -> "Goodbye!\n"
      _ -> get_command(data)
    end
  end

  def load_csv() do
    IO.gets("Name of .csv to load: ")
    |> String.trim()
    |> read()
    |> parse()
    |> get_command()
  end

  def prepare_csv(data) do
    headers = ["Item" | get_fields(data)]

    items_rows =
      Map.keys(data)
      |> Enum.map(items, fn item ->
        [item | Map.values(data[item])]
      end)

    [headers | item_rows]
    |> Enum.map(&Enum.join(&1, ","))
    |> Enum.join("\n")
  end

  def save_csv(data) do
    filename = IO.gets("name of .csv to save: ") |> String.trim()
    file_data = prepare_csv(data)

    case(File.write!(filename, fiel_data)) do
      :ok ->
        IO.puts("CSV saved")

      {:error, reason} ->
        IO.puts("Could not save file #{filename}")
        IO.puts(~s{":file.format_error(#{reason})"})
        get_command()
    end
  end

  def read(filename) do
    case(File.read(filename)) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s{An error happened while openning "#{filename}"\n})
        IO.puts(~s{":file.format_error(#{reason})"})
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

  def add_todo(data) do
    name = get_item_name(data)
    titles = get_fields(data)
    fields = Enum.map(titles, fn field -> field_from_user(field) end)

    %{name => Enum.into(fields, %{})}
    |> IO.inspect()
    |> Map.merge(data)
    |> get_command()
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

    if Map.has_key?(data, todo) do
      new = Map.drop(data, [todo])
      IO.puts("Done")
      get_command(new)
    else
      IO.puts(~s{There is no Todo named "#{todo}"})
      show_todos(data, false)
    end
  end

  def get_item_name(data) do
    name = IO.gets("Enter the name of the new Todo: ") |> String.trim()

    if Map.has_key?(data, name) do
      IO.puts("Todo with that name already exists!!")
      get_item_name(data)
    else
      name
    end
  end

  def get_fields(data) do
    data[hd(Map.keys(data))] |> Map.keys()
  end

  def field_from_user(name) do
    field = IO.gets("#{name}: ") |> String.trim()
    {name, field}
  end
end
