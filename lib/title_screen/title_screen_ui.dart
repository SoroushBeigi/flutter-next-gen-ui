import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next_gen_ui/title_screen/diff_buttons.dart';
import 'package:flutter_next_gen_ui/title_screen/start_button.dart';
import 'package:gap/gap.dart';

import '../assets.dart';
import '../common/ui_scaler.dart';
import '../styles.dart';

class TitleScreenUi extends StatelessWidget {
   const TitleScreenUi({
    super.key,
    required this.difficulty,
    required this.onDifficultyPressed,
    required this.onDifficultyFocused,
  });

  final int difficulty;
  final void Function(int difficulty) onDifficultyPressed;
  final void Function(int? difficulty) onDifficultyFocused; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      child: Stack(
        children: [
          const TopLeft(
            child: UiScaler(
              alignment: Alignment.topLeft,
              child: _TitleText(),
            ),
          ),
           BottomLeft(            
            child: UiScaler(
              alignment: Alignment.bottomLeft,
              child: DifficultyButtons(
                difficulty: difficulty,
                onDifficultyPressed: onDifficultyPressed,
                onDifficultyFocused: onDifficultyFocused,
              ),
            ),
          ),   
           BottomRight(                                    
            child: UiScaler(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 40),
                child: StartButton(onPressed: () {}),
              ),
            ),
          ),                                                                                
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(-(TextStyles.h1.letterSpacing! * .5), 0),
              child: Text('OUTPOST', style: TextStyles.h1),
            ),
            Image.asset(AssetPaths.titleSelectedLeft, height: 65),
            Text('57', style: TextStyles.h2),
            Image.asset(AssetPaths.titleSelectedRight, height: 65),
          ],
        ),
        Text('INTO THE UNKNOWN', style: TextStyles.h3),
      ],
    );
  }
}
