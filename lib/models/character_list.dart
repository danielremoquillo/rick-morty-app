import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/character_tile.dart';
import 'package:rick_morty_api/widgets/theme.dart';

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
          child: Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, top: 19.0, bottom: 10.0),
            child: Text(
              'Characters',
              style: AppTheme.pageTileHeader,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return CharacterListTile(
            character: characters[index],
            onTap: () {},
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
