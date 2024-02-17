import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_next_gen_ui/styles.dart';
import 'package:flutter_next_gen_ui/title_screen/animated_colors.dart';
import 'package:flutter_next_gen_ui/title_screen/lit_image.dart';
import 'package:flutter_next_gen_ui/title_screen/title_screen_ui.dart';

import '../assets.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  final _emitAmt = 0.7;
  final _orbaMT = 0.5;

  int _difficulty = 0;
  int? _difficultyOverride;

  void _handleDifficultyPressed(int value) {
    setState(() => _difficulty = value);
  }

  void _handleDifficultyFocused(int? value) {
    setState(() => _difficultyOverride = value);
  }

  Color get _emitColor =>
      AppColors.emitColors[_difficultyOverride ?? _difficulty];
  Color get _orbColor => AppColors.orbColors[_difficultyOverride ?? _difficulty];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedColors(
          orbColor: _orbColor,
          emitColor: _emitColor,
          builder:(context, orbColor, emitColor) => Stack(
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
              Positioned.fill(
                child: TitleScreenUi(
                  difficulty: _difficulty,
                  onDifficultyFocused: _handleDifficultyFocused,
                  onDifficultyPressed: _handleDifficultyPressed,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 1.seconds, delay: .3.seconds),
        ),
      ),
    );
  }
}
