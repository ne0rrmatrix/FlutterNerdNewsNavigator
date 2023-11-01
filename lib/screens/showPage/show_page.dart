import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/components/shows.dart';
import 'package:nerdnewsnavigator3/screens/nav_bar.dart';
import 'package:nerdnewsnavigator3/screens/videoPlayerPage/video_player_page.dart';
import 'package:nerdnewsnavigator3/services.dart';

class ShowPage extends StatefulWidget {
  static String routeName = '/showPage';
  final String showUrl;
  const ShowPage({Key? key, required this.showUrl}) : super(key: key);

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  Future<List<Show>> getUrl() async {
    Services services = Services();
    var shows = await services.getShows(widget.showUrl);

    return shows;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Show>>(
        future: getUrl(),
        builder: (context, AsyncSnapshot<List<Show>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Scaffold(
              drawer: const NavBar(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Show Page'),
              ),
              body: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: List.generate(data.length, growable: true, (int index) {
                    return ListView(
                      children: [
                        Text(data[index].title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerPage(url: data[index].url)));
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: ClipRect(
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  data[index].image,
                                ),
                              )),
                        )
                      ],
                    );
                  })),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              drawer: const NavBar(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Podcast Page'),
              ),
              body: const CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            );
          }
          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Podcast Page'),
            ),
            body: const CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          );
        });
  }
}
