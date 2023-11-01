import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/screens/nav_bar.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  static String routeName = '/videoPlayerPage';
  final String url;
  const VideoPlayerPage({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    controller.initialize().then((value) {
      if (!kIsWeb) controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('test: ${widget.url}');

    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Video Page'),
      ),
      body: JkVideoControlPanel(controller, showFullscreenButton: true, showVolumeButton: true),
    );
  }
}
