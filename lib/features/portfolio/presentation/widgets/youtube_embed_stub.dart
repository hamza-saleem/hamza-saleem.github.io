import 'package:flutter/material.dart';

class YouTubeEmbed extends StatelessWidget {
  final String videoId;
  final String title;
  const YouTubeEmbed({super.key, required this.videoId, required this.title});
  @override
  Widget build(BuildContext context) => Semantics(
    label: '$title video preview',
    child: const ColoredBox(
      color: Colors.black,
      child: Center(
        child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48),
      ),
    ),
  );
}
