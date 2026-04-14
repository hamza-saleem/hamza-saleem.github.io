import 'package:flutter/material.dart';

/// Tracks hover state and exposes it to [builder], eliminating the need for
/// a dedicated StatefulWidget with a `_hovered` field in every hover widget.
///
/// Usage:
/// ```dart
/// HoverBuilder(
///   cursor: SystemMouseCursors.click,
///   builder: (context, hovered) => Container(
///     color: hovered ? Colors.red : Colors.blue,
///   ),
/// )
/// ```
class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.basic,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final MouseCursor cursor;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.cursor,
      child: widget.builder(context, _hovered),
    );
  }
}
