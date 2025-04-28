import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_state.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/music_item.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicListState>(
      builder: (context, state) {
        if (state is MusicPlayerLoadInProgress) {
          return SizedBox(
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          );
        } else if (state is MusicPlayerDataState) {
          return ListView.builder(
            itemBuilder:
                (context, index) => MusicItem(
                  key: Key("music_$index"),
                  music: state.musicList[index],
                  musicIndex: index,
                ),
            itemCount: state.musicList.length,
          );
        }
        return Container(); //empty
      },
    );
  }
}
