import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_control/bloc/music_control_state.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/presentation/pages/now_playing_page.dart';

class BottomBar extends StatelessWidget {
  final MusicEntity? musicEntity;
  const BottomBar({
    super.key,
    this.musicEntity,
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
                      MusicEntity? playing;
                      if (state is PlayingState) {
                        playing = state.nowPlaying;
                      }
                      return NowPlayingPage(
                        musicEntity: playing,
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
                            image: const DecorationImage(
                              image: AssetImage('images/a.jpg'),
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
                    BlocBuilder<MusicControlBloc, MusicControlState>(builder: (context, state) {
                      return IconButton(
                        onPressed: () {
													if(state is PlayingState){
														context.read<MusicControlBloc>().add(PauseEvent(onPause: state.nowPlaying));
													} else if(state is PauseState){
														context.read<MusicControlBloc>().add(PlayEvent(musicEntity: state.onPause));
													} else{
														context.read<MusicControlBloc>().add(PlayEvent());
													}
												},
                        icon: Icon(
                          state is PlayingState
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
