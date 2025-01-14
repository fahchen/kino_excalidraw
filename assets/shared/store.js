import { isEqual } from "lodash";

export function buildStore({ data, options = {} }) {
  let cell = { data, options };

  let currentListener;

  function subscribe(listener) {
    if (currentListener) {
      throw new Error("Multiple subscribers are not supported");
    }

    currentListener = listener;

    return () => {
      currentListener = undefined;
    };
  }

  function getSnapshot() {
    return cell;
  }

  function updateData(data) {
    if (isEqual(cell.data, data)) return;

    cell = { ...cell, data };

    if (currentListener) currentListener();
  }
  function updateOptions(options) {
    if (isEqual(cell.options, options)) return;

    cell = { ...cell, options: { ...options } };

    if (currentListener) currentListener();
  }

  return {
    subscribe,
    getSnapshot,
    updateData,
    updateOptions,
  };
}
