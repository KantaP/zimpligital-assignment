import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/music_item.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MusicPlayerCubit, MusicPlayerState, List<MusicDetail>>(
      selector: (state) => state.musicList,
      builder: (context, musicList) {
        return ListView.builder(
          itemBuilder:
              (context, index) => MusicItem(
                key: Key("music_$index"),
                music: musicList[index],
                musicIndex: index,
              ),
          itemCount: musicList.length,
        );
      },
    );
  }
}
