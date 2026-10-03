class TextMeasureResult {
  const TextMeasureResult({
    required this.maxLineWidth,
    required this.lineCount,
  });
  final double maxLineWidth;
  final int lineCount;
}

class TextMeasurer {
  TextMeasurer._();
  static Future<TextMeasureResult?> measure({
    required String text,
    required String font,
    double maxWidth = 10000,
  }) async => null;
}
