import "core-js/modules/esnext.uint8-array.from-base64.js";
import "core-js/modules/esnext.uint8-array.to-base64.js";

import React, { useState, useSyncExternalStore } from "react";
import { isEqual } from "lodash";
import {
  Excalidraw,
  MainMenu,
  serializeAsJSON,
  Sidebar,
} from "@excalidraw/excalidraw/dist/excalidraw.production.min.js";
import { RiSettingsLine } from "@remixicon/react";

import { Settings } from "./settings";
import { deserializeData, normalizeHeight } from "../../shared/utils";

export function App({ store, onDataChange, onOptionsChange }) {
  const cell = useSyncExternalStore(
    store.subscribe,
    store.getSnapshot,
  );

  function onExcalidrawChange(elements, appState, files) {
    const serialized = serializeAsJSON(
      elements,
      appState,
      files,
      "local",
    );

    if (!isEqual(cell.data, serialized)) onDataChange(serialized);
  }

  function onSettingsChange(updates) {
    onOptionsChange(updates);
  }

  const [excalidrawAPI, setExcalidrawAPI] = useState(null);

  const style = {
    height: `${normalizeHeight(cell.options.height)}px`,
  };

  const initialData = {
    ...deserializeData(cell.data),
    scrollToContent: cell.options.scroll_to_content,
  };

  return (
    <div className="w-full" style={style}>
      <Excalidraw
        onChange={async (...args) => onExcalidrawChange(...args)}
        initialData={initialData}
        viewModeEnabled={cell.options.view_mode_enabled}
        gridModeEnabled={cell.options.grid_mode_enabled}
        zenModeEnabled={cell.options.zen_mode_enabled}
        excalidrawAPI={(api) => setExcalidrawAPI(api)}
      >
        <MainMenu>
          <MainMenu.DefaultItems.LoadScene />
          <MainMenu.DefaultItems.SaveAsImage />
          <MainMenu.DefaultItems.Export />
          <MainMenu.Item
            icon={<RiSettingsLine size={36} />}
            onSelect={() =>
              excalidrawAPI.toggleSidebar({ name: "settings", tab: "viewer" })}
          >
            Settings
          </MainMenu.Item>
          <MainMenu.DefaultItems.ClearCanvas />
          <MainMenu.Separator />
          <MainMenu.DefaultItems.Help />
          <MainMenu.DefaultItems.ToggleTheme />
        </MainMenu>

        <Sidebar name="settings">
          <Sidebar.Header>Settings</Sidebar.Header>
          <Sidebar.Tabs style={{ padding: "0.5rem" }}>
            <Settings options={cell.options} onChange={onSettingsChange} />
          </Sidebar.Tabs>
        </Sidebar>
      </Excalidraw>
    </div>
  );
}
