import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/app.dart';
import 'package:video_player_win/video_player_win_plugin.dart';

Future<void> main() async {
  if (!kIsWeb && Platform.isWindows) WindowsVideoPlayer.registerWith();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;
  runApp(const App());
}
