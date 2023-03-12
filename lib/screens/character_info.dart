import 'package:flutter/material.dart';
import 'package:rick_morty_api/classes/character.dart';
import 'package:rick_morty_api/widgets/theme.dart';

class CharacterProfilePage extends StatelessWidget {
  final Character character;

  const CharacterProfilePage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    character.image,
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 15,
                    left: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.amber,
                        )),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Character Information',
                      style: AppTheme.characterInfoHeader,
                    ),
                    const SizedBox(height: 10),
                    Text(character.name,
                        style: AppTheme.characterInfoSubHeader),
                    const SizedBox(height: 8),
                    Text(
                      'Species: ${character.species}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gender: ${character.gender}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${character.status}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
