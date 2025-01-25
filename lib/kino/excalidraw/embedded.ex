defmodule Kino.Excalidraw.Embedded do
  @moduledoc """
  An Excalidraw component that embeds the data directly into the livebook page.

  See options in `Kino.Excalidraw.Options`.
  """

  use Kino.JS, assets_path: "lib/assets/static/build"

  use TypedStructor

  alias Kino.Excalidraw.Options

  typed_structor do
    field :data, binary(), enforce: true
    field :options, Options.t(), default: %{}
  end

  @valid_options ~w[height scroll_to_content view_mode_enabled zen_mode_enabled grid_mode_enabled]a

  @spec new(attrs :: Enumerable.t()) :: Kino.JS.t()
  def new(attrs \\ []) do
    cell =
      __MODULE__
      |> struct(attrs)
      |> Map.update!(:options, &Options.build(&1, @valid_options))
      |> Map.from_struct()

    Kino.JS.new(__MODULE__, cell)
  end
end
