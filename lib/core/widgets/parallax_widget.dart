import 'package:flutter/material.dart';

class ParallaxWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double parallaxStrength;

  const ParallaxWidget({
    super.key,
    required this.child,
    required this.scrollController,
    this.parallaxStrength = 0.5,
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
    _offsetNotifier.value = widget.scrollController.offset * widget.parallaxStrength;
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateOffset);
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _offsetNotifier,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(0, -offset),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class ParallaxCard extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double parallaxStrength;

  const ParallaxCard({
    super.key,
    required this.child,
    required this.scrollController,
    this.parallaxStrength = 0.3,
  });

  @override
  State<ParallaxCard> createState() => _ParallaxCardState();
}

class _ParallaxCardState extends State<ParallaxCard> {
  late final ValueNotifier<double> _offsetNotifier;

  @override
  void initState() {
    super.initState();
    _offsetNotifier = ValueNotifier(0.0);
    widget.scrollController.addListener(_updateOffset);
  }

  void _updateOffset() {
    _offsetNotifier.value = widget.scrollController.offset * widget.parallaxStrength;
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateOffset);
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _offsetNotifier,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(0, offset * 0.1),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
