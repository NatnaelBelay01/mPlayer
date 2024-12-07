import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicCard extends StatelessWidget {
  final MusicEntity music;
  const MusicCard({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MusicControlBloc>().add(
              PlayThisEvent(musicEntity: music),
            );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 3),
          child: Row(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      music.title.trim(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      music.artist.trim(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
