import 'dart:js_interop';
import 'package:flutter/material.dart';

extension type _IframeElement(JSObject _) implements JSObject {
  external void setAttribute(JSString name, JSString value);
}

class YouTubeEmbed extends StatelessWidget {
  final String videoId;
  final String title;
  const YouTubeEmbed({super.key, required this.videoId, required this.title});

  @override
  Widget build(BuildContext context) => HtmlElementView.fromTagName(
    tagName: 'iframe',
    onElementCreated: (element) {
      final iframe = _IframeElement(element as JSObject);
      final attributes = <String, String>{
        'src': 'https://www.youtube-nocookie.com/embed/$videoId?rel=0',
        'title': 'Know Buddy Games — $title',
        'style': 'width:100%;height:100%;border:0;display:block;',
        'allow':
            'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share; fullscreen',
        'allowfullscreen': '',
        'loading': 'lazy',
        'referrerpolicy': 'strict-origin-when-cross-origin',
      };
      for (final attribute in attributes.entries) {
        iframe.setAttribute(attribute.key.toJS, attribute.value.toJS);
      }
    },
  );
}
