defmodule TodoList do
  # Start

  def start do
    input =
      IO.gets("Would you like to create a new .csv? (y/n)\n")
      |> String.trim()
      |> String.downcase()

    if input == "y" do
      create_initial_todo() |> get_command()
    else
      load_csv()
    end
  end

  # *********************************************************************
  # Commands

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

  # *********************************************************************
  # Create CSV

  def create_headers do
    """
    What Data should each Todo have?
    Enter field names one by one and press enter when you are done\n
    """
    |> IO.puts()

    create_headers([])
  end

  def create_headers(headers) do
    case IO.gets("Add Field: ") |> String.trim() do
      "" -> headers
      header -> create_headers([header | headers])
    end
  end

  def create_initial_todo do
    name = get_item_name(%{})
    fields = create_headers() |> Enum.map(&field_from_user(&1))
    IO.puts(~s{New Todo "#{name}" added.})
    %{name => Enum.into(fields, %{})}
  end

  # *********************************************************************
  # Read & Parse

  def load_csv() do
    IO.gets("Name of .csv to load: ")
    |> String.trim()
    |> read()
    |> parse()
    |> get_command()
  end

  def read(filename) do
    case(File.read(filename)) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s{An error happened while openning "#{filename}"\n})
        IO.puts(~s{":file.format_error(#{reason})"})
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

  # *********************************************************************
  # Todo CRUD

  def add_todo(data) do
    name = get_item_name(data)
    fields = get_fields(data) |> Enum.map(&field_from_user(&1))

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
      IO.puts("Done")

      Map.drop(data, [todo])
      |> get_command()
    else
      IO.puts(~s{There is no Todo named "#{todo}"})
      show_todos(data, false)
    end
  end

  # *********************************************************************
  # Save

  def prepare_csv(data) do
    headers = ["Item" | get_fields(data)]

    item_rows =
      Map.keys(data)
      |> Enum.map(fn item ->
        [item | Map.values(data[item])]
      end)

    [headers | item_rows]
    |> Enum.map(&Enum.join(&1, ","))
    |> Enum.join("\n")
  end

  def save_csv(data) do
    filename = IO.gets("name of .csv to save: ") |> String.trim()
    file_data = prepare_csv(data)

    case(File.write!(filename, file_data)) do
      :ok ->
        IO.puts("CSV saved")

      {:error, reason} ->
        IO.puts("Could not save file #{filename}")
        IO.puts(~s{":file.format_error(#{reason})"})
        get_command(data)
    end
  end

  # *********************************************************************
  # Helpers

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
