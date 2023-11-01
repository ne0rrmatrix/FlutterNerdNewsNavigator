import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/app.dart';
import 'package:video_player_win/video_player_win_plugin.dart';

Future<void> main() async {
  if (!kIsWeb && Platform.isWindows) WindowsVideoPlayer.registerWith();
  runApp(const App());
}
