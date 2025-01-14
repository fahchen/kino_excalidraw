defmodule Kino.Excalidraw.Remote do
  use Kino.JS, assets_path: "lib/assets/static/build"

  use TypedStructor

  alias KinoExcalidraw.Options

  typed_structor do
    field :url, URI.t(), enforce: true
    field :options, Options.t(), default: %{}
  end

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
