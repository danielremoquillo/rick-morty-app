import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/charater_tile.dart';
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
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SvgIcon(
                  size: 35,
                  icon: SvgIconData('Vector.svg'),
                  color: AppTheme.appBarTextColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Rick and Morty',
                  style: AppTheme.appBarTitleText,
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                  text: 'Docs',
                  style: AppTheme.appBarText,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri url = Uri.parse(
                          'https://rickandmortyapi.com/documentation');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    }),
            )
          ],
        ),
        backgroundColor: AppTheme.appBarBackgroundColor,
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
              child: Text('An error has occurred!'),
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

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, top: 19.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Characters',
                      style: AppTheme.pageTileHeader,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => context
                                .read<CharactersProvider>()
                                .skipToFirst(),
                            icon: Icon(
                              Icons.keyboard_double_arrow_left,
                              color:
                                  context.watch<CharactersProvider>().getPage ==
                                          1
                                      ? AppTheme.limitIconColor
                                      : AppTheme.contrastColor,
                            )),
                        IconButton(
                            onPressed: () =>
                                context.read<CharactersProvider>().prevPage(),
                            icon: Icon(
                              Icons.navigate_before,
                              color:
                                  context.watch<CharactersProvider>().getPage ==
                                          1
                                      ? AppTheme.limitIconColor
                                      : AppTheme.contrastColor,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${context.watch<CharactersProvider>().getPage}',
                            style: AppTheme.pageNumberText,
                          ),
                        ),
                        IconButton(
                            onPressed: () =>
                                context.read<CharactersProvider>().nextPage(),
                            icon: Icon(
                              Icons.navigate_next,
                              color:
                                  context.watch<CharactersProvider>().getPage ==
                                          42
                                      ? AppTheme.limitIconColor
                                      : AppTheme.contrastColor,
                            )),
                        IconButton(
                            onPressed: () =>
                                context.read<CharactersProvider>().skipToLast(),
                            icon: Icon(
                              Icons.keyboard_double_arrow_right,
                              color:
                                  context.watch<CharactersProvider>().getPage ==
                                          42
                                      ? AppTheme.limitIconColor
                                      : AppTheme.contrastColor,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return CharacterTile(
            character: characters[index],
          );
        }, childCount: characters.length)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () =>
                        context.read<CharactersProvider>().skipToFirst(),
                    icon: Icon(
                      Icons.keyboard_double_arrow_left,
                      color: context.watch<CharactersProvider>().getPage == 1
                          ? AppTheme.limitIconColor
                          : AppTheme.contrastColor,
                    )),
                IconButton(
                    onPressed: () =>
                        context.read<CharactersProvider>().prevPage(),
                    icon: Icon(
                      Icons.navigate_before,
                      color: context.watch<CharactersProvider>().getPage == 1
                          ? AppTheme.limitIconColor
                          : AppTheme.contrastColor,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${context.watch<CharactersProvider>().getPage}',
                    style: AppTheme.pageNumberText,
                  ),
                ),
                IconButton(
                    onPressed: () =>
                        context.read<CharactersProvider>().nextPage(),
                    icon: Icon(
                      Icons.navigate_next,
                      color: context.watch<CharactersProvider>().getPage == 42
                          ? AppTheme.limitIconColor
                          : AppTheme.contrastColor,
                    )),
                IconButton(
                    onPressed: () =>
                        context.read<CharactersProvider>().skipToLast(),
                    icon: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: context.watch<CharactersProvider>().getPage == 42
                          ? AppTheme.limitIconColor
                          : AppTheme.contrastColor,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
