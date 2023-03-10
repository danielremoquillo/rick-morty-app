import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/character_tile.dart';
import 'package:rick_morty_api/widgets/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      drawer: Drawer(),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rick and Morty API',
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
      body: FutureBuilder<List<Character>>(
        future:
            context.watch<CharactersProvider>().fetchCharacter(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'An error has occurred!',
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
    );
  }
}
