defmodule Kino.Excalidraw.Remote do
  @moduledoc """
  An Excalidraw component that fetches the data from a remote URL.

  See options in `Kino.Excalidraw.Options`.
  """

  use Kino.JS, assets_path: "lib/assets/static/build"

  use TypedStructor

  alias Kino.Excalidraw.Options

  typed_structor do
    field :url, URI.t(), enforce: true
    field :options, Options.t(), default: %{}
  end

  @spec new(attrs :: Enumerable.t()) :: Kino.JS.t()
  def new(attrs \\ []) do
    cell =
      __MODULE__
      |> struct(attrs)
      |> Map.update!(:url, &URI.new!/1)
      |> Map.update!(:options, &Options.build/1)

    data = Req.get!(cell.url).body

    Kino.JS.new(__MODULE__, %{data: data, options: cell.options})
  end
end
