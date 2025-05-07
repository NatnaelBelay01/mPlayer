import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_control/bloc/music_control_state.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/presentation/pages/now_playing_page.dart';

class BottomBar extends StatelessWidget {
  final MusicEntity? musicEntity;
  final AudioPlayer player;
  const BottomBar({
    super.key,
    this.musicEntity,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BlocBuilder<MusicControlBloc, MusicControlState>(
                        builder: (context, state) {
                      if (state is PlayingState) {
                        final playing = state.nowPlaying;
                        final player = state.player;

                        return NowPlayingPage(
                          musicEntity: playing,
                          player: player,
                        );
                      }
                      final player = (state as PlaylistLoadSuccess).player;
                      return NowPlayingPage(
                        player: player,
                      );
                    });
                  });
            },
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
                            image: DecorationImage(
                              image: (musicEntity == null ||
                                      musicEntity!.photoByte == null)
                                  ? const AssetImage('images/a.jpg')
                                  : MemoryImage(musicEntity!.photoByte!),
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 180,
                              child: Text(
                                musicEntity != null
                                    ? musicEntity!.title.trim()
                                    : "Remedy",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 180,
                              child: Text(
                                musicEntity != null
                                    ? musicEntity!.artist.trim()
                                    : "Annie Schider",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    StreamBuilder<PlayerState>(
                        stream: player.playerStateStream,
                        builder: (context, snapshot) {
                          final playing = snapshot.data?.playing;
                          return IconButton(
                            onPressed: () async {
                              if (playing == true) {
                                await player.pause();
                              } else {
                                await player.play();
                              }
                            },
                            icon: Icon(
                              playing == true
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 45,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
