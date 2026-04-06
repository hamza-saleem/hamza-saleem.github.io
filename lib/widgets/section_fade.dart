import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionFade extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const SectionFade({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: 0.06, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
