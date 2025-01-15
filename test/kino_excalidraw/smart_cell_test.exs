defmodule KinoExcalidraw.SmartCellTest do
  use ExUnit.Case, async: true

  import Kino.Test

  alias KinoExcalidraw.SmartCell

  setup :configure_livebook_bridge

  describe "new/1" do
    test "works without attrs" do
      cell = SmartCell.new()
      assert is_struct(cell)
    end

    test "works with atom key attrs" do
      cell = SmartCell.new(%{"data" => "{}", "options" => %{"height" => 700}})
      assert 700 === cell.options.height
    end

    test "works with string key attrs" do
      cell = SmartCell.new(data: "{}", options: %{height: 700})
      assert 700 === cell.options.height
    end

    test "ignores unexpected attrs" do
      cell = SmartCell.new(data: "{}", options: %{height: 700, foo: :bar}, foo: :bar)
      refute Map.has_key?(cell.options, :foo)
    end
  end

  describe "initialization" do
    test "restores source code from attrs" do
      attrs = %{
        "variable" => "graph",
        "data" => "{}",
        "options" => %{"height" => 700}
      }

      {_kino, source} = start_smart_cell!(SmartCell, attrs)

      assert source ==
               """
               graph = KinoExcalidraw.SmartCell.new(data: "{}", options: %{height: 700})\
               """
    end
  end

  describe "handle_event" do
    test "broadcast update_data event" do
      attrs = %{
        "variable" => "graph",
        "data" => "{}",
        "options" => %{"height" => 700}
      }

      {kino, _source} = start_smart_cell!(SmartCell, attrs)
      payload = ~S|{"elements": []}|
      push_event(kino, "update_data", payload)
      assert_broadcast_event(kino, "update_data", ^payload)

      assert_smart_cell_update(
        kino,
        %{
          variable: "graph",
          data: ^payload,
          options: %{height: 700}
        },
        """
        graph = KinoExcalidraw.SmartCell.new(data: "{\\\"elements\\\": []}", options: %{height: 700})\
        """
      )
    end

    test "broadcast update_options event" do
      attrs = %{
        "variable" => "graph",
        "data" => "{}",
        "options" => %{"height" => 700}
      }

      {kino, _source} = start_smart_cell!(SmartCell, attrs)

      push_event(kino, "update_options", %{"view_mode_enabled" => true})
      options = %{height: 700, view_mode_enabled: true}
      assert_broadcast_event(kino, "update_options", ^options)

      assert_smart_cell_update(
        kino,
        %{
          variable: "graph",
          data: "{}",
          options: ^options
        },
        """
        graph =
          KinoExcalidraw.SmartCell.new(
            data: "{}",
            options: %{height: 700, view_mode_enabled: true}
          )\
        """
      )
    end
  end
end
