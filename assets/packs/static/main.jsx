import React from "react";
import { createRoot } from "react-dom/client";

import { App } from "./app";
import { buildStore } from "../../shared/store";
import "../../shared/main.css";

export function init(ctx, payload) {
  const store = buildStore(payload);

  const root = createRoot(ctx.root);
  root.render(
    <App store={store} />,
  );
}
