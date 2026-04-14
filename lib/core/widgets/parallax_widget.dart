import 'package:flutter/material.dart';

/// A widget that applies a parallax translation effect on scroll.
///
/// [parallaxStrength] controls how many pixels to offset per scroll pixel.
/// [invert] reverses the direction and applies a 0.1 dampening factor —
/// use this for subtle card-floating effects.
class ParallaxWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double parallaxStrength;

  /// When false (default): content moves up as the page scrolls down.
  /// When true: content floats down slightly (dampened by 0.1).
  final bool invert;

  const ParallaxWidget({
    super.key,
    required this.child,
    required this.scrollController,
    this.parallaxStrength = 0.5,
    this.invert = false,
  });

  @override
  State<ParallaxWidget> createState() => _ParallaxWidgetState();
}

class _ParallaxWidgetState extends State<ParallaxWidget> {
  late final ValueNotifier<double> _offsetNotifier;

  @override
  void initState() {
    super.initState();
    _offsetNotifier = ValueNotifier(0.0);
    widget.scrollController.addListener(_updateOffset);
  }

  void _updateOffset() {
    final newOffset =
        widget.scrollController.offset * widget.parallaxStrength;
    // Skip rebuild if the visual delta is sub-pixel — reduces rebuilds at 60fps+.
    if ((_offsetNotifier.value - newOffset).abs() < 0.5) return;
    _offsetNotifier.value = newOffset;
  }

  @override
  void dispose() {
    try {
      widget.scrollController.removeListener(_updateOffset);
    } catch (_) {}
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _offsetNotifier,
      builder: (context, offset, child) {
        final dy = widget.invert ? offset * 0.1 : -offset;
        return Transform.translate(
          offset: Offset(0, dy),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
