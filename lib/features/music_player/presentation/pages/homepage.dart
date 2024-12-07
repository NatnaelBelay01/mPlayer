import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_control/bloc/music_control_state.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/presentation/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mplayer/core/theme/color_pallet.dart';
import 'package:mplayer/core/utils/show_snack_bar.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_bloc.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_event.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_state.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              context.read<MusicBloc>().add(MusicFetchFromStorage());
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
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
            child:
                BlocConsumer<MusicBloc, MusicState>(listener: (context, state) {
              if (state is LoadingFailure) {
                showSnackBar(context, state.message);
              }
            }, builder: (context, state) {
              if (state is MusicLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadSuccess) {
								context.read<MusicControlBloc>().add(LoadPlaylistEvent(musicList: state.result));
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: state.result.length,
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (BuildContext context, int index) {
                    return MusicCard(music: state.result[index]);
                  },
                );
              }
              return const SizedBox();
            }),
          ),
          BlocBuilder<MusicControlBloc, MusicControlState>(
            builder: (context, state) {
							MusicEntity? nowPlaying;
							if(state is PlayingState){
								nowPlaying = state.nowPlaying;
							}
              return Positioned(
                bottom: 1,
                left: 1,
                child: BottomBar(musicEntity: nowPlaying,),
              );
            }
          ),
        ],
      ),
    );
  }
}
