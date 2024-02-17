import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_next_gen_ui/orb_shader/orb_shader_config.dart';
import 'package:flutter_next_gen_ui/orb_shader/orb_shader_widget.dart';
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

class _TitleScreenState extends State<TitleScreen>
    with SingleTickerProviderStateMixin {
  final _orbKey = GlobalKey<OrbShaderWidgetState>();

  final _minReceiveLightAmt = .35;
  final _maxReceiveLightAmt = .7;

  final _minEmitLightAmt = .5;
  final _maxEmitLightAmt = 1;

  var _mousePos = Offset.zero;
  int _difficulty = 0;
  int? _difficultyOverride;

  double _orbEnergy = 0;
  double _minOrbEnergy = 0;

  Color get _emitColor =>
      AppColors.emitColors[_difficultyOverride ?? _difficulty];
  Color get _orbColor =>
      AppColors.orbColors[_difficultyOverride ?? _difficulty];

  double get _finalReceiveLightAmt {
    final light =
        lerpDouble(_minReceiveLightAmt, _maxReceiveLightAmt, _orbEnergy) ?? 0;
    return light + _pulseEffect.value * .05 * _orbEnergy;
  }

  double get _finalEmitLightAmt {
    return lerpDouble(_minEmitLightAmt, _maxEmitLightAmt, _orbEnergy) ?? 0;
  }

  late final _pulseEffect = AnimationController(
    vsync: this,
    duration: _getRndPulseDuration(),
    lowerBound: -1,
    upperBound: 1,
  );

  Duration _getRndPulseDuration() => 100.ms + 200.ms * Random().nextDouble();

  double _getMinEnergyForDifficulty(int difficulty) => switch (difficulty) {
        1 => 0.3,
        2 => 0.6,
        _ => 0,
      };
  @override
  void initState() {
    super.initState();
    _pulseEffect.forward();
    _pulseEffect.addListener(_handlePulseEffectUpdate);
  }

  void _handlePulseEffectUpdate() {
    if (_pulseEffect.status == AnimationStatus.completed) {
      _pulseEffect.reverse();
      _pulseEffect.duration = _getRndPulseDuration();
    } else if (_pulseEffect.status == AnimationStatus.dismissed) {
      _pulseEffect.duration = _getRndPulseDuration();
      _pulseEffect.forward();
    }
  }

  void _handleDifficultyPressed(int value) {
    setState(() => _difficulty = value);
    _bumpMinEnergy();
  }

  Future<void> _bumpMinEnergy([double amount = 0.1]) async {
    setState(() {
      _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty) + amount;
    });
    await Future<void>.delayed(.2.seconds);
    setState(() {
      _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty);
    });
  }

  void _handleStartPressed() => _bumpMinEnergy(0.3);

  void _handleDifficultyFocused(int? value) {
    setState(() {
      _difficultyOverride = value;
      if (value == null) {
        _minOrbEnergy = _getMinEnergyForDifficulty(_difficulty);
      } else {
        _minOrbEnergy = _getMinEnergyForDifficulty(value);
      }
    });
  }

  /// Update mouse position so the orbWidget can use it, doing it here prevents
  /// buttons from blocking the mouse-move events in the widget itself.
  void _handleMouseMove(PointerHoverEvent e) {
    setState(() {
      _mousePos = e.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MouseRegion(
          onHover: _handleMouseMove,
          child: AnimatedColors(
            orbColor: _orbColor,
            emitColor: _emitColor,
            builder: (context, orbColor, emitColor) => Stack(
              children: [
                Image.asset(AssetPaths.titleBgBase),
                LitImage(
                  color: orbColor,
                  imgSrc: AssetPaths.titleBgReceive,
                  lightAmt: _finalReceiveLightAmt,
                  pulseEffect: _pulseEffect,
                ),

                /// Orb
                Positioned.fill(
                  child: Stack(
                    children: [
                      // Orb
                      OrbShaderWidget(
                        key: _orbKey,
                        mousePos: _mousePos,
                        minEnergy: _minOrbEnergy,
                        config: OrbShaderConfig(
                          ambientLightColor: orbColor,
                          materialColor: orbColor,
                          lightColor: orbColor,
                        ),
                        onUpdate: (energy) => setState(() {
                          _orbEnergy = energy;
                        }),
                      ),
                    ],
                  ),
                ),

                LitImage(
                  color: orbColor,
                  imgSrc: AssetPaths.titleMgBase,
                  lightAmt: _finalReceiveLightAmt,
                  pulseEffect: _pulseEffect,
                ),
                LitImage(
                  color: orbColor,
                  imgSrc: AssetPaths.titleMgReceive,
                  lightAmt: _finalReceiveLightAmt,
                  pulseEffect: _pulseEffect,
                ),
                LitImage(
                    color: emitColor,
                    imgSrc: AssetPaths.titleMgEmit,
                    lightAmt: _finalEmitLightAmt,
                    pulseEffect: _pulseEffect,),
                Image.asset(
                  AssetPaths.titleFgBase,
                ),
                LitImage(
                  color: orbColor,
                  imgSrc: AssetPaths.titleFgReceive,
                  lightAmt: _finalReceiveLightAmt,
                  pulseEffect: _pulseEffect,
                ),
                LitImage(
                  color: emitColor,
                  imgSrc: AssetPaths.titleFgEmit,
                  lightAmt: _finalEmitLightAmt,
                  pulseEffect: _pulseEffect,
                ),
                Positioned.fill(
                  child: TitleScreenUi(
                    difficulty: _difficulty,
                    onDifficultyFocused: _handleDifficultyFocused,
                    onDifficultyPressed: _handleDifficultyPressed,
                    onStartPressed: _handleStartPressed,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 1.seconds, delay: .3.seconds),
          ),
        ),
      ),
    );
  }
}
