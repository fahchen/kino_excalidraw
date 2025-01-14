defmodule KinoExcalidraw.Options do
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
    |> Enum.map(&build_option/1)
    |> Map.new()
  end

  defp build_option(option_value_tuple)

  defp build_option({option, value}) when is_binary(option) do
    build_option({String.to_existing_atom(option), value})
  end

  defp build_option({:height, value}) when is_integer(value) and value > 0 do
    {:height, value}
  end

  defp build_option({:scroll_to_content, value}) when is_boolean(value) do
    {:scroll_to_content, value}
  end

  defp build_option({:view_mode_enabled, value}) when is_boolean(value) do
    {:view_mode_enabled, value}
  end

  defp build_option({:zen_mode_enabled, value}) when is_boolean(value) do
    {:zen_mode_enabled, value}
  end

  defp build_option({:grid_mode_enabled, value}) when is_boolean(value) do
    {:grid_mode_enabled, value}
  end
end
