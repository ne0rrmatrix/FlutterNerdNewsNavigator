import 'package:flutter/material.dart';
import 'package:nerdnewsnavigator3/components/podcast.dart';
import 'package:nerdnewsnavigator3/screens/nav_bar.dart';
import 'package:nerdnewsnavigator3/screens/showPage/show_page.dart';
import 'package:nerdnewsnavigator3/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PodcastPage extends StatefulWidget {
  static String routeName = '/podcastPage';

  const PodcastPage({Key? key}) : super(key: key);

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  Future<List<Podcast>> getUrl() async {
    Services services = Services();
    return services.getPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Podcast>>(
        future: getUrl(),
        builder: (context, AsyncSnapshot<List<Podcast>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Scaffold(
              drawer: const NavBar(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Podcast Page'),
              ),
              body: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: List.generate(data.length, growable: true, (int index) {
                    return ListView(
                      children: [
                        Text('${data[index].title}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ShowPage(showUrl: data[index].url!)));
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: ClipRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl: '${data[index].image}',
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ))),
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
                body: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrangeAccent,
                  ),
                ));
          }
          return Scaffold(
              drawer: const NavBar(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Podcast Page'),
              ),
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrangeAccent,
                ),
              ));
        });
  }
}
