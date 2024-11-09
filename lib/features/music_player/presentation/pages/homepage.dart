import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mplayer/core/theme/color_pallet.dart';
import 'package:mplayer/features/music_player/presentation/pages/music_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('mPlayer'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: ColorPallet.greyBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: 20,
              clipBehavior: Clip.antiAlias,
              itemBuilder: (BuildContext context, int index) {
                return const MusicCard();
              },
            ),
          ),
          Positioned(
            bottom: 1,
            left: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('images/a.jpg'),
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                children: [
                                  Text(
                                    "Remedy",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Annie Schindel",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.pause_circle,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
