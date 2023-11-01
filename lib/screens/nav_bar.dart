import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/screens/editPage/edit_page.dart';
import 'package:nerdnewsnavigator3/screens/podcastPage/podcast_page.dart';
import 'package:nerdnewsnavigator3/screens/settingsPage/settings_page.dart';
import 'package:nerdnewsnavigator3/screens/videoPlayerPage/live_stream.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PodcastPage()),
                );
              }),
          ListTile(
              title: const Text("Edit"),
              leading: const Icon(Icons.edit),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPage()),
                );
              }),
          ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }),
          ListTile(
              title: const Text("Live Player"),
              leading: const Icon(Icons.video_file),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LivePlayerPage()),
                );
              }),
        ],
      ),
    );
  }
}
