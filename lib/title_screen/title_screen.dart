import 'package:flutter/material.dart';
import 'package:flutter_next_gen_ui/styles.dart';
import 'package:flutter_next_gen_ui/title_screen/lit_image.dart';

import '../assets.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  final _emitAmt = 0.7;
  final _orbaMT = 0.5;

  @override
  Widget build(BuildContext context) {
    final orbColor = AppColors.orbColors[0];
    final emitColor = AppColors.emitColors[0];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Image.asset(AssetPaths.titleBgBase),
            LitImage(
              color: orbColor,
              imgSrc: AssetPaths.titleBgReceive,
              lightAmt: _orbaMT,
            ),
            LitImage(
              color: orbColor,
              imgSrc: AssetPaths.titleMgBase,
              lightAmt: _orbaMT,
            ),
            LitImage(
              color: orbColor,
              imgSrc: AssetPaths.titleMgReceive,
              lightAmt: _orbaMT,
            ),
            LitImage(
                color: emitColor,
                imgSrc: AssetPaths.titleMgEmit,
                lightAmt: _emitAmt),
            Image.asset(
              AssetPaths.titleFgBase,
            ),
            LitImage(
              color: orbColor,
              imgSrc: AssetPaths.titleFgReceive,
              lightAmt: _orbaMT,
            ),
            LitImage(
              color: emitColor,
              imgSrc: AssetPaths.titleFgEmit,
              lightAmt: _emitAmt,
            ),
          ],
        ),
      ),
    );
  }
}
