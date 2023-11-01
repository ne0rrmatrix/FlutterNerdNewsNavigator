class YoutubeExtractor {
  String? extractVideoId(String url) {
    if (url.contains(' ')) {
      return null;
    }

    late final Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return null;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    // youtube.com/watch?v=xxxxxxxxxxx
    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        (uri.pathSegments.first == 'watch' ||
            uri.pathSegments.first == 'live') &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v']!;
      return _isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return _isValidId(videoId) ? videoId : null;
    }

    // www.youtube.com/shorts/xxxxxxxxxxx
    // youtube.com/shorts/xxxxxxxxxxx
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      final pathSegments = uri.pathSegments;
      if (pathSegments.contains('shorts') && pathSegments.length >= 2) {
        final videoId = pathSegments.last;
        return _isValidId(videoId) ? videoId : null;
      }
    }

    return null;
  }

  bool _isValidId(String id) => RegExp(r'^[_\-a-zA-Z0-9]{11}$').hasMatch(id);
}
