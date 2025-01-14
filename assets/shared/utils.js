import {
  restore,
} from "@excalidraw/excalidraw/dist/excalidraw.production.min.js";

export function deserializeData(data) {
  if (data) {
    try {
      const json = JSON.parse(data);
      return restore(json);
    } catch (_e) {
      return {};
    }
  } else {
    return {};
  }
}

export const DEFAULT_HEIGHT = 600;
export const MIN_HEIGHT = 500;

export function normalizeHeight(value, minHeight = MIN_HEIGHT) {
  if (!Number.isInteger(value)) {
    const int = Number(value);

    if (Number.isNaN(int)) return DEFAULT_HEIGHT;

    return normalizeHeight(int);
  }

  if (value < minHeight) return minHeight;

  return value;
}
