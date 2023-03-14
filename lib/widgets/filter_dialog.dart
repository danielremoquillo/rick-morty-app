import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/providers/character_queries.dart';
import 'package:rick_morty_api/providers/characters.dart';
import 'package:rick_morty_api/widgets/filter_group.dart';
import 'package:rick_morty_api/widgets/theme.dart';

class FilterDialogBar extends StatelessWidget {
  const FilterDialogBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    return AlertDialog(
                      icon: const Icon(
                        Icons.filter_alt,
                        color: AppTheme.scaffoldBackgroundColor,
                      ),
                      buttonPadding: const EdgeInsets.all(10),
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
                            context.read<CharacterQueryProvider>().resetQuery();
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Reset',
                            style: AppTheme.appDialogueButtons,
                          ),
                          onPressed: () {
                            context.read<CharacterQueryProvider>().resetQuery();
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
                                  borderRadius: BorderRadius.circular(18.0))),
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
                                Provider.of<CharacterQueryProvider>(context,
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
    );
  }
}
