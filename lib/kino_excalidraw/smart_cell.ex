defmodule KinoExcalidraw.SmartCell do
  @moduledoc """
  A SmartCell for embedding and editing Excalidraw diagrams in Livebook notebooks.
  This SmartCell allows you to create and modify Excalidraw graphs, and configure various editor options.

  See options in `Kino.Excalidraw.Options`.
  """

  use Kino.JS, assets_path: "lib/assets/smart_cell/build"
  use Kino.JS.Live
  use Kino.SmartCell, name: "Excalidraw"

  use TypedStructor

  alias Kino.Excalidraw.Options

  typed_structor do
    field :data, binary()
    field :options, Options.t(), default: %{}
  end

  @spec new(attrs :: Enumerable.t()) :: __MODULE__.t()
  def new(attrs \\ []) do
    __MODULE__
    |> struct(atomize_attrs(attrs))
    |> Map.update!(:options, &Options.build/1)
    |> Map.update!(:options, &set_variable/1)
  end

  valid_keys = ~w[data options]a

  defp atomize_attrs(attrs) do
    Enum.flat_map(attrs, fn
      {key, value} when key in unquote(valid_keys) -> [{key, value}]
      {"data", data} -> [{:data, data}]
      {"options", options} -> [{:options, options}]
      _other -> []
    end)
  end

  defp set_variable(%{variable: variable} = options) when not is_nil(variable) do
    if Kino.SmartCell.valid_variable_name?(variable) do
      Map.update!(
        options,
        :variable,
        &Kino.SmartCell.prefixed_var_name("excalidraw", &1)
      )
    else
      # drop invalid variable name
      Map.delete(options, :variable)
    end
  end

  defp set_variable(options), do: options

  @impl true
  def init(attrs, ctx) do
    {:ok, assign(ctx, cell: new(attrs))}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, Map.take(ctx.assigns.cell, [:data, :options]), ctx}
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
    Map.take(ctx.assigns.cell, [:data, :options])
  end

  @impl true
  def to_source(cell) do
    variable = Map.get(cell.options, :variable)

    if variable do
      variable = quoted_var(variable)
      data = Macro.escape(cell.data)
      options = Macro.escape(cell.options)

      quote do
        unquote(variable) =
          KinoExcalidraw.SmartCell.new(
            data: unquote(data),
            options: unquote(options)
          )
      end
      |> Kino.SmartCell.quoted_to_string()
    else
      quote do
        Kino.nothing()
      end
      |> Kino.SmartCell.quoted_to_string()
    end
  end

  defp quoted_var(string), do: {String.to_atom(string), [], nil}

  defimpl Kino.Render do
    def to_livebook(_cell) do
      %{type: :ignored}
    end
  end
end
