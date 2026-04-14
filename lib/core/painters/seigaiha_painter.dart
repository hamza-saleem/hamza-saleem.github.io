import 'dart:math' as math;
import 'package:flutter/material.dart';

class SeigaihaPainter extends CustomPainter {
  final Color color;
  final double opacity;
  final double scale;

  const SeigaihaPainter({
    required this.color,
    this.opacity = 0.04,
    this.scale = 40,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final r = scale;
    final colSpacing = r * 2;
    final rowSpacing = r;

    final cols = (size.width / colSpacing).ceil() + 2;
    final rows = (size.height / rowSpacing).ceil() + 2;

    final path = Path();
    for (int row = -1; row < rows; row++) {
      for (int col = -1; col < cols; col++) {
        final xOffset = (row % 2 == 0) ? 0.0 : r;
        final cx = col * colSpacing + xOffset;
        final cy = row * rowSpacing;
        final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
        path.addArc(rect, math.pi, math.pi);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SeigaihaPainter old) =>
      old.color != color || old.opacity != opacity || old.scale != scale;
}

class SeigaihaBackground extends StatelessWidget {
  final Widget child;

  const SeigaihaBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              willChange: false,
              painter: SeigaihaPainter(
                color: isDark ? Colors.white : Colors.black,
                opacity: isDark ? 0.035 : 0.06,
                scale: 36,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
