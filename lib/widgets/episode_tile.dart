import 'package:flutter/material.dart';

import 'package:rick_morty_api/widgets/theme.dart';

// ignore: must_be_immutable
class EpisodeListTile extends StatelessWidget {
  final Text title;
  final Text subtitle;

  const EpisodeListTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(height: 4.0),
                  subtitle,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
