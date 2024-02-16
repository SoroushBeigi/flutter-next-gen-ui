import 'package:flutter/material.dart';

import '../assets.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Image.asset(AssetPaths.titleBgBase),
            Image.asset(AssetPaths.titleBgReceive),
            Image.asset(AssetPaths.titleMgBase),
            Image.asset(AssetPaths.titleMgReceive),
            Image.asset(AssetPaths.titleMgEmit),
            Image.asset(AssetPaths.titleFgBase),
            Image.asset(AssetPaths.titleFgReceive),
            Image.asset(AssetPaths.titleFgEmit),
          ],
        ),
      ),
    );
  }
}
