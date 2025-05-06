import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mplayer/core/theme/color_pallet.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_control/bloc/music_control_state.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class NowPlayingPage extends StatelessWidget {
  final MusicEntity? musicEntity;
  final AudioPlayer player;

  const NowPlayingPage({super.key, this.musicEntity, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.expand_more),
        ),
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
            alignment: const Alignment(0, -0.75),
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (musicEntity == null || musicEntity?.photoByte == null)
                      ? const AssetImage('images/a.jpg')
                      : MemoryImage(musicEntity!.photoByte!),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 20.0,
              sigmaX: 20.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 26, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 330,
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: (musicEntity == null ||
                                  musicEntity!.photoByte == null)
                              ? const AssetImage('images/a.jpg')
                              : MemoryImage(musicEntity!.photoByte!),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    musicEntity != null ? musicEntity!.title : 'Remedy',
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    musicEntity != null
                        ? musicEntity!.artist
                        : 'Annie Schindel',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    onChanged: (value) {},
                    min: 0,
                    max: 2,
                    value: 0.3,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("1:46"), Text("3:40")],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.music_note),
                      Icon(Icons.favorite_border),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 334,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorPallet.greyBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "UP NEXT",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(Icons.dehaze),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "I'm Fine",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Text(
                                    "Ashe",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "2:16",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorPallet.greyBackgroundColor,
                          child: const Icon(
                            Icons.shuffle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await player.seekToPrevious();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorPallet.greyBackgroundColor,
                          child: const Icon(Icons.skip_previous,
                              color: Colors.white),
                        ),
                      ),
                      StreamBuilder<PlayerState>(
                          stream: player.playerStateStream,
                          builder: (context, snapshot) {
                            final playingState = snapshot.data;
                            final playing = playingState?.playing;
                            return GestureDetector(
                              onTap: () async {
                                if (playing == true) {
                                  await player.pause();
                                } else {
                                  await player.play();
                                }
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  playing == true
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 45,
                                ),
                              ),
                            );
                          }),
                      GestureDetector(
                        onTap: () async {
                          await player.seekToNext();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorPallet.greyBackgroundColor,
                          child:
                              const Icon(Icons.skip_next, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorPallet.greyBackgroundColor,
                          child: const Icon(Icons.repeat, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
