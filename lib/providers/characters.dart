import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CharactersProvider with ChangeNotifier {
  int _page = 1;
  String category = 'Characters';

  int get getPage => _page;
  void nextPage() {
    if (_page == 42) {
      _page = 42;
    } else {
      _page++;
    }
    notifyListeners();
  }

  void prevPage() {
    if (_page == 1) {
      _page = 1;
    } else {
      _page--;
    }
    notifyListeners();
  }

  void skipToFirst() {
    _page = 1;
    notifyListeners();
  }

  void skipToLast() {
    _page = 42;
    notifyListeners();
  }

  Future<List<Character>> fetchCharacter(http.Client client) async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$_page'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseCharacter, response.body);
  }

// A function that converts a response body into a List<Photo>.
  List<Character> parseCharacter(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return parsed['results']
        .map<Character>((json) => Character.fromJson(json))
        .toList();
  }
}
