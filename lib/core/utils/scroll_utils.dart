import 'package:flutter/material.dart';

/// Smoothly scrolls the viewport so the widget bound to [key] is visible.
/// No-ops if the key has no current context (widget not yet mounted).
void scrollToKey(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx == null) return;
  Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOut,
    alignment: 0.0,
  );
}
