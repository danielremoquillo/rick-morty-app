import 'package:flutter/material.dart';
import 'package:rick_morty_api/providers/characters.dart';

import 'package:rick_morty_api/screens/testhome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CharactersProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: TestScreen(),
    );
  }
}
