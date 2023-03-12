import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/screens/character_info.dart';
import 'package:rick_morty_api/widgets/theme.dart';

// ignore: must_be_immutable
class CharacterListTile extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  CharacterListTile({
    Key? key,
    required this.onTap,
    required this.character,
  }) : super(key: key);

  Map<String, Color> status = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.grey
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CharacterProfilePage(character: character)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(character.image,
                  height: 100.0, width: 100.0, fit: BoxFit.cover, frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: child,
                );
              }),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: AppTheme.characterTileHeader,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: status[character.status],
                        size: 8,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${character.status} - ${character.species}',
                        style: AppTheme.characterTileText.copyWith(
                            fontSize: character.species.length > 18 ? 11 : 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'First Seen: ',
                    style: AppTheme.characterTileTextHeader,
                  ),
                  Text(
                    character.location['name'],
                    style: AppTheme.characterTileText,
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
