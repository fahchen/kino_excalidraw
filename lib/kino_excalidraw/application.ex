defmodule KinoExcalidraw.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Kino.SmartCell.register(KinoExcalidraw.SmartCell)

    children = []
    opts = [strategy: :one_for_one, name: KinoExcalidraw.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
