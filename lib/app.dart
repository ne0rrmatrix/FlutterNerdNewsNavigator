import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/screens/downloadShowsPage/downloaded_shows_page.dart';
import 'package:nerdnewsnavigator3/screens/editPage/edit_page.dart';
import 'package:nerdnewsnavigator3/screens/podcastPage/podcast_page.dart';
import 'package:nerdnewsnavigator3/screens/settingsPage/settings_page.dart';
import 'package:nerdnewsnavigator3/screens/showPage/show_page.dart';
import 'package:nerdnewsnavigator3/screens/videoPlayerPage/live_stream.dart';
import 'package:nerdnewsnavigator3/screens/videoPlayerPage/video_player_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const PodcastPage(),
        '/downloadShowPage': (context) => const DownloadedShowsPage(),
        '/editPage': (context) => const EditPage(),
        '/showPage': (context) => const ShowPage(
              showUrl: '',
            ),
        '/videoPlayerPage': (context) => const VideoPlayerPage(
              url: '',
            ),
        '/settingsPage': (context) => const SettingsPage(),
        '/livePlayerPage': (context) => const LivePlayerPage(),
      },
    );
    //home: const PodcastPage(),
  }
}
