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
               grid_mode_enabled: true,
               variable: "graph"
             } ===
               Options.build(%{
                 "height" => 600,
                 "scroll_to_content" => true,
                 "view_mode_enabled" => true,
                 "zen_mode_enabled" => true,
                 "grid_mode_enabled" => true,
                 "variable" => "graph"
               })
    end

    test "works for atom keys" do
      assert %{
               height: 600,
               scroll_to_content: true,
               view_mode_enabled: true,
               zen_mode_enabled: true,
               grid_mode_enabled: true,
               variable: "graph"
             } ===
               Options.build(%{
                 height: 600,
                 scroll_to_content: true,
                 view_mode_enabled: true,
                 zen_mode_enabled: true,
                 grid_mode_enabled: true,
                 variable: "graph"
               })
    end

    test "accpets the valid options" do
      assert %{
               height: 600
             } ===
               Options.build(
                 %{
                   height: 600,
                   scroll_to_content: true,
                   view_mode_enabled: true,
                   zen_mode_enabled: true,
                   grid_mode_enabled: true,
                   variable: "graph"
                 },
                 [:height]
               )
    end

    test "ignores unexpected options" do
      assert %{height: 600} === Options.build(%{height: 600, foo: :bar})
    end
  end
end
