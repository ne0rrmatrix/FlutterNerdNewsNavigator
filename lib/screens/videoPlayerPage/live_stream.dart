import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/screens/nav_bar.dart';
import 'package:nerdnewsnavigator3/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';

class LivePlayerPage extends StatefulWidget {
  static String routeName = '/livePlayerPage';
  const LivePlayerPage({Key? key}) : super(key: key);

  @override
  State<LivePlayerPage> createState() => _LivePlayerPageState();
}

class _LivePlayerPageState extends State<LivePlayerPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  Future<String> getUrl() async {
    Services service = Services();
    var url = await service.getHLSUrl();

    _controller = VideoPlayerController.networkUrl(Uri.parse(url.toString()));
    _controller.initialize().then((value) {
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
      );
      if (!kIsWeb) _controller.play();
      setState(() {});
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUrl(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              title: const Text('Video Page'),
            ),
            body: JkVideoControlPanel(_controller, showFullscreenButton: true, showVolumeButton: true),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              title: const Text('Live Video Player'),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            ),
          );
        }
        return Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            title: const Text('Live Video Player'),
          ),
          body: const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          ),
        );
      }),
    );
  }
}
