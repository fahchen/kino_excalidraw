import React from "react";
import { InputField, OptionField } from "./field";
import { MIN_HEIGHT, normalizeHeight } from "../../../shared/utils";

export function Settings({ options, onChange }) {
  return (
    <div className="p-4 flex-col space-y-4">
      <InputField
        label="Height (px)"
        type="number"
        min={MIN_HEIGHT}
        step={10}
        defaultValue={normalizeHeight(options.height)}
        onChange={(e) => onChange({ height: normalizeHeight(e.target.value) })}
      />
      <OptionField
        label="Scroll to content"
        defaultChecked={normalizeBoolean(options.scroll_to_content)}
        onChange={(e) =>
          onChange({ scroll_to_content: normalizeBoolean(e.target.checked) })}
      />
      <div className="flex flex-col space-y-2">
        <p className="font-semibold text-gray-900">Modes</p>
        <OptionField
          label="View Mode"
          defaultChecked={normalizeBoolean(options.view_mode_enabled)}
          onChange={(e) =>
            onChange({ view_mode_enabled: normalizeBoolean(e.target.checked) })}
        />
        <OptionField
          label="Zen Mode"
          defaultChecked={normalizeBoolean(options.zen_mode_enabled)}
          onChange={(e) =>
            onChange({ zen_mode_enabled: normalizeBoolean(e.target.checked) })}
        />
        <OptionField
          label="Grid Mode"
          defaultChecked={normalizeBoolean(options.grid_mode_enabled)}
          onChange={(e) =>
            onChange({ grid_mode_enabled: normalizeBoolean(e.target.checked) })}
        />
      </div>
      <InputField
        label="Variable"
        description="The name of the variable used in the source code is usually not needed. However, this can lead to an issue where Livebook may hang when the graph becomes too complex."
        type="text"
        defaultValue={options.variable}
        onChange={(e) => onChange({ variable: e.target.value })}
      />
    </div>
  );
}

function normalizeBoolean(value) {
  return !!value;
}
