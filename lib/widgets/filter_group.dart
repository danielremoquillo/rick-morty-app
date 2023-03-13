import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_api/providers/character_queries.dart';
import 'package:rick_morty_api/widgets/theme.dart';

class CharacterFilterGroupButton extends StatelessWidget {
  const CharacterFilterGroupButton(
      {super.key,
      required this.buttonMap,
      required this.groupLabel,
      this.selectedButton});

  final Map<String, String> buttonMap;
  final String groupLabel;
  final String? selectedButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          groupLabel,
          textAlign: TextAlign.start,
          style: AppTheme.appDialogueFilterGroupHeader,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomRadioButton(
          defaultSelected: context
                      .watch<CharacterQueryProvider>()
                      .getMapQuery[groupLabel] ==
                  ''
              ? null
              : context.watch<CharacterQueryProvider>().getMapQuery[groupLabel],
          autoWidth: true,
          elevation: 0,
          enableShape: true,
          customShape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(20.0)),
          unSelectedColor: AppTheme.scaffoldBackgroundColor,
          unSelectedBorderColor: Colors.amber,
          buttonLables: buttonMap.keys.toList(),
          buttonValues: buttonMap.values.toList(),
          buttonTextStyle: ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: Colors.amber,
              textStyle: AppTheme.appDialogueFilterButtons),
          enableButtonWrap: true,
          wrapAlignment: WrapAlignment.center,
          radioButtonValue: (value) {
            context
                .read<CharacterQueryProvider>()
                .stageQuery(value, groupLabel);
          },
          selectedColor: Colors.amber,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
