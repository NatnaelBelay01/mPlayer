import 'dart:ui';

import 'package:flutter/material.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.expand_more),
        title: const Row(
          children: [
            SizedBox(width: 60),
            Text("Now Playing"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.5),
            child: Container(
              width: 270,
              height: 270,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/a.jpg'),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 20.0,
              sigmaX: 20.0,
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}
