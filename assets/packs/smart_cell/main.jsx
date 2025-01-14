import React from "react";
import { createRoot } from "react-dom/client";
import { debounce } from "lodash";

import { buildStore } from "../../shared/store";
import "../../shared/main.css";
import { App } from "./app";

export function init(ctx, payload) {
  const store = buildStore(payload);

  ctx.importCSS("main.css");

  ctx.handleEvent("update_data", (data) => {
    store.updateData(data);
  });

  ctx.handleEvent("update_options", (options) => {
    store.updateOptions(options);
  });

  const onDataChange = debounce((data) => {
    ctx.pushEvent("update_data", data);
  }, 200);

  const onOptionsChange = debounce((updates) => {
    ctx.pushEvent("update_options", updates);
  }, 200);

  const root = createRoot(ctx.root);
  root.render(
    <App
      store={store}
      onDataChange={onDataChange}
      onOptionsChange={onOptionsChange}
    />,
  );
}
