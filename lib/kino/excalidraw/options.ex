defmodule Kino.Excalidraw.Options do
  @moduledoc """
  The options for configuring the Excalidraw editor.


  | Option | Description | Default |
  |--------|-------------| ------- |
  | `:height` | The height of the editor in pixels. | `600` |
  | `:scroll_to_content` | Whether to scroll to the content when the editor is loaded. | `true` |
  | `:view_mode_enabled` | Whether the view mode is enabled. | `false` |
  | `:zen_mode_enabled` | Whether the zen mode is enabled. | `false` |
  | `:grid_mode_enabled` | Whether the grid mode is enabled. | `false` |
  """

  @type t() :: %{
          optional(:height) => pos_integer(),
          optional(:scroll_to_content) => boolean(),
          optional(:view_mode_enabled) => boolean(),
          optional(:zen_mode_enabled) => boolean(),
          optional(:grid_mode_enabled) => boolean()
        }

  @spec build(Enumerable.t(tuple())) :: t()
  def build(options) do
    options
    |> Enum.flat_map(&build_option/1)
    |> Map.new()
  end

  defp build_option(option_value_tuple)

  defp build_option({"height", value}) when is_integer(value) and value > 0 do
    [{:height, value}]
  end

  defp build_option({:height, value}) when is_integer(value) and value > 0 do
    [{:height, value}]
  end

  boolean_options = ~w[scroll_to_content view_mode_enabled zen_mode_enabled grid_mode_enabled]a

  for option <- boolean_options do
    option_str = Atom.to_string(option)

    defp build_option({unquote(option_str), value}) when is_boolean(value) do
      [{unquote(option), value}]
    end

    defp build_option({unquote(option), value}) when is_boolean(value) do
      [{unquote(option), value}]
    end
  end

  defp build_option(_other), do: []
end
