defmodule KinoExcalidraw.MixProject do
  use Mix.Project

  @version "0.3.0"
  @description "Excalidraw integration with Livebook"

  def project do
    [
      app: :kino_excalidraw,
      version: @version,
      description: @description,
      elixir: "~> 1.14",
      name: "KinoExcalidraw",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
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
      {:req, "~> 0.5.8"},

      # Dev only
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "components",
      source_url: "https://github.com/fahchen/kino_excalidraw",
      source_ref: "v#{@version}",
      extras: ["guides/components.livemd"]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/fahchen/kino_excalidraw"
      }
    ]
  end
end
