import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/providers/character_queries.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/character_tile.dart';
import 'package:rick_morty_api/widgets/filter_group.dart';
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Characters',
                  style: AppTheme.pageTileHeader,
                  textAlign: TextAlign.start,
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          print(context
                              .watch<CharacterQueryProvider>()
                              .getTempQuery['Status']);
                          return AlertDialog(
                            icon: const Icon(
                              Icons.filter_alt,
                              color: AppTheme.scaffoldBackgroundColor,
                            ),
                            buttonPadding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            backgroundColor: AppTheme.scaffoldBackgroundColor,
                            title: Text(
                              'Filter Characters',
                              style: AppTheme.appDialogueHeader,
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CharacterFilterGroupButton(
                                  groupLabel: 'Status',
                                  buttonMap: {
                                    'Alive': '&status=alive',
                                    'Dead': '&status=dead',
                                    'Unknown': '&status=unknown'
                                  },
                                ),
                                CharacterFilterGroupButton(
                                  groupLabel: 'Species',
                                  buttonMap: {
                                    'Human': '&species=human',
                                    'Unknown': '&species=unknown',
                                    'Alien': '&species=alien',
                                    'Humanoid': '&species=humanoid'
                                  },
                                ),
                                CharacterFilterGroupButton(
                                  groupLabel: 'Gender',
                                  buttonMap: {
                                    'Female': '&gender=female',
                                    'Male': '&gender=male',
                                    'Unknown': '&gender=unknown',
                                    'Genderless': '&gender=genderless'
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Close',
                                  style: AppTheme.appDialogueButtons,
                                ),
                                onPressed: () {
                                  context
                                      .read<CharacterQueryProvider>()
                                      .resetQuery();
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Reset',
                                  style: AppTheme.appDialogueButtons,
                                ),
                                onPressed: () {
                                  context
                                      .read<CharacterQueryProvider>()
                                      .resetQuery();
                                  Provider.of<CharacterQueryProvider>(context,
                                          listen: false)
                                      .pushQuery();
                                  Provider.of<CharactersProvider>(context,
                                          listen: false)
                                      .clearQuery();
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0))),
                                child: Text(
                                  'Apply',
                                  style: AppTheme.appDialogueButtons,
                                ),
                                onPressed: () {
                                  //Passes the temp map query to the actual mapquery
                                  Provider.of<CharacterQueryProvider>(context,
                                          listen: false)
                                      .pushQuery();

                                  //Ensures that loading will be at the first page
                                  Provider.of<CharactersProvider>(context,
                                          listen: false)
                                      .skipToFirst();
                                  context.read<CharactersProvider>().setQuery(
                                      Provider.of<CharacterQueryProvider>(
                                              context,
                                              listen: false)
                                          .getMapQuery
                                          .values
                                          .join(''));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.filter_list_outlined,
                      color: Colors.white,
                    ))
              ],
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
            padding: const EdgeInsets.all(10.0),
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
                      color: context.watch<CharactersProvider>().getPage ==
                              context.watch<CharactersProvider>().getmaxPage
                          ? AppTheme.limitIconColor
                          : AppTheme.contrastColor,
                    )),
                IconButton(
                    onPressed: () =>
                        context.read<CharactersProvider>().skipToLast(),
                    icon: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: context.watch<CharactersProvider>().getPage ==
                              context.watch<CharactersProvider>().getmaxPage
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
