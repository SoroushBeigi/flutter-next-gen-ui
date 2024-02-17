import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_next_gen_ui/assets.dart';
import 'package:flutter_next_gen_ui/styles.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';

class StartButton extends StatefulWidget {
  const StartButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  AnimationController? _btnAnim;
  bool _wasHovered = false;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      cursor: SystemMouseCursors.click,
      onPressed: widget.onPressed,
      builder: (_, state) {
        if ((state.isHovered || state.isFocused) &&
            !_wasHovered &&
            _btnAnim?.status != AnimationStatus.forward) {
          _btnAnim?.forward(from: 0);
        }
        _wasHovered = (state.isHovered || state.isFocused);
        return SizedBox(
          width: 520,
          height: 100,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(AssetPaths.titleStartBtn)),
              if (state.isHovered || state.isFocused) ...[
                Positioned.fill(
                    child: Image.asset(AssetPaths.titleStartBtnHover)),
              ],
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('START MISSION',
                        style: TextStyles.btn
                            .copyWith(fontSize: 24, letterSpacing: 18)),
                  ],
                ),
              ),
            ],
          ).animate(autoPlay: false, onInit: (c) => _btnAnim = c)
              .shimmer(duration: .7.seconds, color: Colors.black),
        ).animate()
            .fadeIn(delay: 2.5.seconds)
            .slide(begin: const Offset(0, .2));
      },
    );
  }
}