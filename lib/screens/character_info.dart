import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/classes/episode.dart';
import 'package:rick_morty_api/providers/episodes.dart';
import 'package:rick_morty_api/widgets/episode_tile.dart';
import 'package:rick_morty_api/widgets/theme.dart';

import 'package:http/http.dart' as http;

class CharacterProfilePage extends StatelessWidget {
  final Character character;

  const CharacterProfilePage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Character Information',
          style: AppTheme.appBarTitleText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              character.image,
              height: 350,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(character.name, style: AppTheme.characterInfoHeader),
                  const SizedBox(height: 16),
                  EpisodeListTile(
                    title: Text(
                      'Origin',
                      style: AppTheme.characterInfoSubHeader,
                    ),
                    subtitle: Text(character.origin['name'],
                        style: AppTheme.characterInfoSubText),
                  ),
                  EpisodeListTile(
                    title: Text(
                      'First Seen',
                      style: AppTheme.characterInfoSubHeader,
                    ),
                    subtitle: Text(character.location['name'],
                        style: AppTheme.characterInfoSubText),
                  ),
                  EpisodeListTile(
                    title: Text(
                      'Species',
                      style: AppTheme.characterInfoSubHeader,
                    ),
                    subtitle: Text(character.species,
                        style: AppTheme.characterInfoSubText),
                  ),
                  EpisodeListTile(
                    title: Text(
                      'Gender',
                      style: AppTheme.characterInfoSubHeader,
                    ),
                    subtitle: Text(character.gender,
                        style: AppTheme.characterInfoSubText),
                  ),
                  EpisodeListTile(
                    title: Text(
                      'Status',
                      style: AppTheme.characterInfoSubHeader,
                    ),
                    subtitle: Text(character.status,
                        style: AppTheme.characterInfoSubText),
                  ),
                  const SizedBox(height: 32),
                  Text('Episodes', style: AppTheme.characterInfoHeader),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: context
                        .watch<EpisodesProvider>()
                        .fetchEpisode(http.Client(), character.episode),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'No Episode found!',
                            style: TextStyle(color: AppTheme.contrastColor),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.tv_outlined,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    snapshot.data![index]['title'],
                                    style: AppTheme.characterInfoSubText,
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['episode_name'],
                                    style: AppTheme.characterInfoSubHeader,
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(100.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
