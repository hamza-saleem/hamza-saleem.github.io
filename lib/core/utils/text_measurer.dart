import 'dart:js_interop';
import 'package:flutter/foundation.dart';

// ---------------------------------------------------------------------------
// JS interop types
// ---------------------------------------------------------------------------

extension type _MeasureResult._(JSObject _) implements JSObject {
  external double get maxLineWidth;
  external int get lineCount;
}

@JS('_pretext.measureText')
external JSPromise<_MeasureResult> _jsMeasureText(
  JSString text,
  JSString font,
  JSNumber maxWidth,
);

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

class TextMeasureResult {
  const TextMeasureResult({
    required this.maxLineWidth,
    required this.lineCount,
  });

  /// Widest line in pixels given the requested maxWidth.
  /// Pass maxWidth = 10000 to get the natural (unwrapped) text width.
  final double maxLineWidth;

  /// Number of lines the text breaks into at the requested maxWidth.
  final int lineCount;
}

class TextMeasurer {
  TextMeasurer._();

  /// Measures [text] using pretext running in the browser.
  ///
  /// [font] must be a CSS font string, e.g. `'700 56px "Noto Serif JP"'`.
  /// [maxWidth] is the container width in logical pixels (pass 10000 for
  /// natural/unwrapped width).
  ///
  /// Returns null on non-web platforms or if pretext failed to load.
  static Future<TextMeasureResult?> measure({
    required String text,
    required String font,
    double maxWidth = 10000,
  }) async {
    if (!kIsWeb) return null;
    try {
      final result = await _jsMeasureText(
        text.toJS,
        font.toJS,
        maxWidth.toJS,
      ).toDart;
      return TextMeasureResult(
        maxLineWidth: result.maxLineWidth,
        lineCount: result.lineCount,
      );
    } catch (_) {
      return null;
    }
  }
}
