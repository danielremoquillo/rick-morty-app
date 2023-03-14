import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EpisodesProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchEpisode(
      http.Client client, List<dynamic> episodes) async {
    List<Map<String, dynamic>> fetchedEpisode = [];
    for (var episode in episodes) {
      final response = await client.get(Uri.parse(episode));
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);

        fetchedEpisode.add({
          'episode_name': '${decodedJson['episode']}',
          'title': decodedJson['name']
        });
      } else {
        throw Exception('Failed to fetch photos');
      }
    }

    return fetchedEpisode;
  }
}
