defmodule Kino.Excalidraw.OptionsTest do
  use ExUnit.Case, async: true

  alias Kino.Excalidraw.Options

  describe "build/1" do
    test "works for string keys" do
      assert %{
               height: 600,
               scroll_to_content: true,
               view_mode_enabled: true,
               zen_mode_enabled: true,
               grid_mode_enabled: true
             } ===
               Options.build(%{
                 "height" => 600,
                 "scroll_to_content" => true,
                 "view_mode_enabled" => true,
                 "zen_mode_enabled" => true,
                 "grid_mode_enabled" => true
               })
    end

    test "works for atom keys" do
      assert %{
               height: 600,
               scroll_to_content: true,
               view_mode_enabled: true,
               zen_mode_enabled: true,
               grid_mode_enabled: true
             } ===
               Options.build(%{
                 height: 600,
                 scroll_to_content: true,
                 view_mode_enabled: true,
                 zen_mode_enabled: true,
                 grid_mode_enabled: true
               })
    end
  end
end
