// Loads pretext from jsDelivr CDN and exposes a single async helper on
// window._pretext so Dart's JS interop can call it without a build step.
import {
  prepare,
  measureLineStats,
} from 'https://cdn.jsdelivr.net/npm/@chenglou/pretext@0.0.5/dist/layout.js';

/**
 * Waits for all fonts declared in CSS to finish loading, then uses pretext
 * to measure `text` with the given CSS `font` string.
 *
 * Returns { lineCount, maxLineWidth } where maxLineWidth is the widest line
 * in pixels when the text is laid out within `maxWidth`.
 * Pass maxWidth = 10000 to get the natural (unwrapped) text width.
 */
async function measureText(text, font, maxWidth) {
  try {
    await document.fonts.ready;
    const prepared = prepare(text, font);
    const { lineCount, maxLineWidth } = measureLineStats(prepared, maxWidth);
    return { lineCount, maxLineWidth };
  } catch (e) {
    console.error('[pretext] measureText failed:', e);
    return { lineCount: 0, maxLineWidth: 0 };
  }
}

window._pretext = { measureText };
