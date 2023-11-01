import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nerdnewsnavigator3/components/podcast.dart';
import 'package:nerdnewsnavigator3/components/shows.dart';
import 'package:xml2json/xml2json.dart';
import 'package:opml/opml.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Services {
  var item = 'https://feeds.twit.tv/twitshows_video_hd.opml';

  YoutubeExplode youtube = YoutubeExplode();
  //YoutubeHttpClient client = YoutubeHttpClient();

  Future<String> getLiveUrl() async {
    String item = "https://www.youtube.com/user/twit";
    http.Response response = await http.get(Uri.parse(item));
    var result = response.body.toString();
    var start = result.indexOf('watch?v=') + 8;
    var end = start + 11;
    var url = result.substring(start, end);
    var string = 'https://www.youtube.com/watch?v=$url';
    return string;
  }

  Future<String> getHLSUrl() async {
    var yt = YoutubeExplode();
    var item = await getLiveUrl();
    var temp = await yt.videos.get(item);

    var result = await yt.videos.streams.getHttpLiveStreamUrl(temp.id);
    yt.close();
    return result;
  }

  Future<List<Show>> getShows(String url) async {
    Xml2Json xml2json = Xml2Json();
    //print('url: $url');
    http.Response response = await http.get(Uri.parse(url));
    xml2json.parse(response.body);
    var jsondata = xml2json.toBadgerfish(useLocalNameForNodes: true);
    var data = jsonDecode(jsondata);
    List<Show> shows = [];
    if (data == null) {
      return shows;
    }
    var list = data['rss']['channel']['item'];
    for (var temp in list) {
      Show item = Show();
      item.title = temp['title'][0]['\$'];
      item.description = temp['description']['__cdata'].toString().substring(3);
      item.image = temp['image']['@href'];
      item.url = temp['enclosure']['@url'];
      shows.add(item);
    }
    return shows;
  }

  Future<List<String>> getPodcastList() async {
    http.Response response = await http.get(Uri.parse(item));
    final xml = response.body.toString();
    final doc = OpmlDocument.parse(xml);
    List<String> myList = [];
    for (var category in doc.body) {
      myList.add(category.xmlUrl.toString());
    }
    return myList;
  }

  Future<List<Podcast>> getPodcasts() async {
    List<Podcast> podcasts = [];
    var result = await getPodcastList();
    for (var element in result) {
      Xml2Json xml2json = Xml2Json();
      http.Response response = await http.get(Uri.parse(element));
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var data = jsonDecode(jsondata);
      var list = data['rss']['channel'];
      Podcast podcast = Podcast();
      podcast.title = list['title'];
      podcast.description = list['description'];
      podcast.url = element;
      podcast.image = list['image']['url'];
      podcast.pubDate = list['pubDate'];
      podcasts.add(podcast);
    }

    return podcasts;
  }
}
