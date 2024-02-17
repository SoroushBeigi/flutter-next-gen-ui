import 'package:flutter/material.dart';

class LitImage extends StatelessWidget {
  final Color color;
  final String imgSrc;
  final double lightAmt;
  final AnimationController pulseEffect;
  const LitImage({
    super.key,
    required this.color,
    required this.imgSrc,
    required this.lightAmt,
    required this.pulseEffect,
  });

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    return ListenableBuilder(
       listenable: pulseEffect,
      builder: (context, child) =>  Image.asset(
        imgSrc,
        color: hsl.withLightness(hsl.lightness * lightAmt).toColor(),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }
}
