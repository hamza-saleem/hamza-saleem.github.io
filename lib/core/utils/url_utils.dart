import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches [url] in the platform's default handler.
/// Logs a debug message if the URL cannot be opened; never throws.
Future<void> launchSafely(String url) async {
  try {
    await launchUrl(Uri.parse(url));
  } catch (e) {
    debugPrint('Could not launch $url: $e');
  }
}
