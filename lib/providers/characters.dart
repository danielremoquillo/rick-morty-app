import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CharactersProvider with ChangeNotifier {
  int _currentpage = 1;
  int _maxPage = 0;

  String _query = '';

  void setQuery(String query) {
    _query += query;
    notifyListeners();
  }

  void removeQuery(String query) {
    _query = _query.replaceAll(query, '');
    notifyListeners();
  }

  int get getPage => _currentpage;
  int get getmaxPage => _maxPage;

  void nextPage() {
    if (_currentpage == _maxPage) {
      _currentpage = _maxPage;
    } else {
      _currentpage++;
    }
    notifyListeners();
  }

  void prevPage() {
    if (_currentpage == 1) {
      _currentpage = 1;
    } else {
      _currentpage--;
    }
    notifyListeners();
  }

  void skipToFirst() {
    _currentpage = 1;
    notifyListeners();
  }

  void skipToLast() {
    _currentpage = _maxPage;
    notifyListeners();
  }

  Future<List<Character>> fetchCharacter(http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=$_currentpage$_query'));
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      _maxPage = ((decodedJson['info']['pages']));

      return decodedJson['results']
          .map<Character>((json) => Character.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch photos');
    }
    // Use the compute function to run parsePhotos in a separate isolate.
  }

//   Future<void> nextPageCharacter(http.Client client) async {
//     final response = await client.get(Uri.parse(characterQueryInfo['next']));
//     if (response.statusCode == 200) {
//       final decodedJson = json.decode(response.body);
//       characterQueryInfo = decodedJson['info']
//           .map<Character>((json) => Character.fromJson(json))
//           .toList();
//       notifyListeners();
//       return decodedJson['info']
//           .map<Character>((json) => Character.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('Failed to fetch photos');
//     }
//   }
}
