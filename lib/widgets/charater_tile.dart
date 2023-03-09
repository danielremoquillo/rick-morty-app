import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/widgets/theme.dart';

// ignore: must_be_immutable
class CharacterTile extends StatelessWidget {
  CharacterTile({super.key, required this.character});

  final Character character;

  List<Color> status = [Colors.green, Colors.red, Colors.grey];

  int statusCode(String status) {
    if (status == 'Alive') {
      return 0;
    } else if (status == 'Dead') {
      return 1;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
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
                      color: status[statusCode(character.status)],
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
