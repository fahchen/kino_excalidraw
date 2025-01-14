defmodule KinoExcalidraw.MixProject do
  use Mix.Project

  def project do
    [
      app: :kino_excalidraw,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {KinoExcalidraw.Application, []}
    ]
  end

  defp deps do
    [
      {:kino, "~> 0.14"},
      {:typed_structor, "~> 0.5"},
      {:req, "~> 0.5.8"}
    ]
  end
end
