import 'package:flutter/material.dart';

class GameEmbed extends StatelessWidget {
  final String url;
  final String title;
  const GameEmbed({super.key, required this.url, required this.title});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Play in a web browser.'));
}
