import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_state.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/music_item.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayerLoadInProgress) {
          return const CircularProgressIndicator();
        } else if (state is MusicPlayerLoadSuccess) {
          return ListView.builder(
            itemBuilder:
                (context, index) => MusicItem(
                  key: Key("music_$index"),
                  music: state.musicPlayer.playList[index],
                  musicIndex: index,
                ),
            itemCount: state.musicPlayer.playList.length,
          );
        }
        return Container(); //empty 
      },
    );
  }
}
