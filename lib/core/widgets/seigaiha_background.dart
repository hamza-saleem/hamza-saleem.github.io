import 'package:flutter/material.dart';
import '../painters/seigaiha_painter.dart';

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
