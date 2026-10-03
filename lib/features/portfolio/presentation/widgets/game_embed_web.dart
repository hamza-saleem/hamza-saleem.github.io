import 'dart:js_interop';
import 'package:flutter/material.dart';

extension type _Frame(JSObject _) implements JSObject {
  external void setAttribute(JSString name, JSString value);
}

class GameEmbed extends StatelessWidget {
  final String url;
  final String title;
  const GameEmbed({super.key, required this.url, required this.title});
  @override
  Widget build(BuildContext context) => HtmlElementView.fromTagName(
    tagName: 'iframe',
    onElementCreated: (element) {
      final frame = _Frame(element as JSObject);
      for (final entry in <String, String>{
        'src': url,
        'title': '$title — playable game',
        'style':
            'width:100%;height:100%;border:0;display:block;background:#000;',
        'allow': 'autoplay; fullscreen; gamepad',
        'allowfullscreen': '',
        'referrerpolicy': 'strict-origin-when-cross-origin',
      }.entries) {
        frame.setAttribute(entry.key.toJS, entry.value.toJS);
      }
    },
  );
}
