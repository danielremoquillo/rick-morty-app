import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/widgets/theme.dart';

// ignore: must_be_immutable
class CharacterTile extends StatelessWidget {
  CharacterTile({super.key, required this.character});

  final Character character;

  Map<String, Color> status = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.grey
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: AppTheme.characterTileColor),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0)),
            child: Image.network(
              character.image,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  character.name,
                  style: AppTheme.characterTileHeader,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: status[character.status],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${character.status} - ${character.species}',
                      style: AppTheme.characterTileText,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
