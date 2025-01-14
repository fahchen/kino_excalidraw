defmodule Kino.Excalidraw.Embedded do
  use Kino.JS, assets_path: "lib/assets/static/build"

  use TypedStructor

  alias KinoExcalidraw.Options

  typed_structor do
    field :data, binary(), enforce: true
    field :options, Options.t(), default: %{}
  end

  def new(attrs \\ []) do
    cell =
      __MODULE__
      |> struct(attrs)
      |> Map.update!(:options, &Options.build/1)
      |> Map.from_struct()

    Kino.JS.new(__MODULE__, cell)
  end
end
