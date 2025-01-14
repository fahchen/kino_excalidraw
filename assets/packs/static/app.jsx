import React, { useSyncExternalStore } from "react";
import {
  Excalidraw,
  MainMenu,
} from "@excalidraw/excalidraw/dist/excalidraw.production.min.js";

import { deserializeData, normalizeHeight } from "../../shared/utils";

export function App({ store }) {
  const cell = useSyncExternalStore(
    store.subscribe,
    store.getSnapshot,
  );

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
        initialData={initialData}
        viewModeEnabled={cell.options.view_mode_enabled}
        gridModeEnabled={cell.options.grid_mode_enabled}
        zenModeEnabled={cell.options.zen_mode_enabled}
      >
        <MainMenu>
          <MainMenu.DefaultItems.LoadScene />
          <MainMenu.DefaultItems.SaveAsImage />
          <MainMenu.DefaultItems.Export />
          <MainMenu.DefaultItems.ClearCanvas />
          <MainMenu.Separator />
          <MainMenu.DefaultItems.Help />
          <MainMenu.DefaultItems.ToggleTheme />
        </MainMenu>
      </Excalidraw>
    </div>
  );
}
