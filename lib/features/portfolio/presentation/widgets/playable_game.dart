import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/url_utils.dart';
import 'game_embed.dart';

class PlayableGame extends StatefulWidget {
  final String url;
  final String title;
  final String pageUrl;
  const PlayableGame({
    super.key,
    required this.url,
    required this.title,
    required this.pageUrl,
  });
  @override
  State<PlayableGame> createState() => _PlayableGameState();
}

class _PlayableGameState extends State<PlayableGame> {
  bool _playing = false;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Play the game', style: AppTextStyles.heading2(context.textPrimary)),
      const SizedBox(height: 8),
      Text(
        'Mouse and keyboard recommended. The game loads when you choose Play here.',
        style: AppTextStyles.body(context.textSecondary),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          FilledButton.icon(
            onPressed: () => setState(() => _playing = !_playing),
            icon: Icon(_playing ? Icons.stop : Icons.play_arrow),
            label: Text(_playing ? 'Close game' : 'Play here'),
          ),
          TextButton(
            onPressed: () => launchSafely(widget.pageUrl),
            child: const Text('Play on itch.io'),
          ),
        ],
      ),
      if (_playing) ...[
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 980 / 620,
          child: GameEmbed(url: widget.url, title: widget.title),
        ),
      ],
    ],
  );
}
