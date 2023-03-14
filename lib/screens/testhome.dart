import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/filter_dialog.dart';
import 'package:rick_morty_api/widgets/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TestScreen extends StatelessWidget {
  TestScreen({super.key});

  //Testing
  Map<String, String> queryMap = {
    'Alive': '&status=alive',
    'Dead': '&status=dead',
    'Unknown': '&status=unknown'
  };
  //Testing

  final List<String> queryKeys = ['Alive', 'Dead', 'Unknown'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rick and Morty App',
              style: AppTheme.appBarTitleText,
            ),
            InkWell(
                child: Text(
                  'Docs',
                  style: AppTheme.appBarText,
                ),
                onTap: () async {
                  final Uri url =
                      Uri.parse('https://rickandmortyapi.com/documentation');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                })
          ],
        ),
        titleTextStyle: const TextStyle(
            color: AppTheme.appBarTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'Segoe UI'),
      ),
      body: Column(
        children: [
          const FilterDialogBar(),
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: context
                  .watch<CharactersProvider>()
                  .fetchCharacter(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'No character found!',
                      style: TextStyle(color: AppTheme.contrastColor),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return CharacterList(characters: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      //Testing
    );
  }
}
