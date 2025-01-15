defmodule KinoExcalidraw.SmartCell do
  use Kino.JS, assets_path: "lib/assets/smart_cell/build"
  use Kino.JS.Live
  use Kino.SmartCell, name: "Excalidraw"

  use TypedStructor

  alias KinoExcalidraw.Options

  typed_structor do
    field :variable, binary(), default: "excalidraw"
    field :data, binary()
    field :options, Options.t(), default: %{}
  end

  def new(attrs \\ []) do
    __MODULE__
    |> struct(atomize_attrs(attrs))
    |> Map.update!(:options, &Options.build/1)
    |> Map.update!(
      :variable,
      &Kino.SmartCell.prefixed_var_name("excalidraw", &1)
    )
  end

  defp atomize_attrs(attrs) do
    Enum.map(attrs, fn
      {key, value} when is_atom(key) -> {key, value}
      {"variable", variable} -> {:variable, variable}
      {"data", data} -> {:data, data}
      {"options", options} -> {:options, options}
    end)
  end

  @impl true
  def init(attrs, ctx) do
    {:ok, assign(ctx, cell: new(attrs))}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, Map.take(ctx.assigns.cell, [:variable, :data, :options]), ctx}
  end

  @impl true
  def handle_event("update_data", data, ctx) do
    ctx =
      update(ctx, :cell, fn cell ->
        if ctx.assigns.cell.data != data do
          broadcast_event(ctx, "update_data", data)
        end

        %__MODULE__{cell | data: data}
      end)

    {:noreply, ctx}
  end

  def handle_event("update_options", options, ctx) do
    ctx =
      update(ctx, :cell, fn cell ->
        old_options = ctx.assigns.cell.options

        new_options =
          options
          |> Options.build()
          |> Enum.into(old_options)

        if old_options != new_options do
          broadcast_event(ctx, "update_options", new_options)
        end

        %__MODULE__{cell | options: new_options}
      end)

    {:noreply, ctx}
  end

  @impl true
  def to_attrs(ctx) do
    %{
      "variable" => ctx.assigns.cell.variable,
      "data" => ctx.assigns.cell.data,
      "options" => ctx.assigns.cell.options
    }
  end

  @impl true
  def to_source(cell) do
    variable = quoted_var(cell["variable"])
    data = Macro.escape(cell["data"])
    options = Macro.escape(cell["options"])

    quote do
      unquote(variable) =
        KinoExcalidraw.SmartCell.new(
          data: unquote(data),
          options: unquote(options)
        )
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  defp quoted_var(string), do: {String.to_atom(string), [], nil}

  defimpl Kino.Render do
    def to_livebook(_cell) do
      %{type: :ignored}
    end
  end
end
