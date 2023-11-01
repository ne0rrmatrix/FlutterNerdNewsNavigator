import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/screens/nav_bar.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    controller.pause();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('my-widget-key'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction == 0) {
          controller.pause();
        }
      },
      child: video(context),
    );
  }

  Widget video(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Video Page'),
      ),
      body: JkVideoControlPanel(controller, showFullscreenButton: true, showVolumeButton: true),
    );
  }
}
