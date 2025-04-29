import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';

class MusicPlayButton extends StatelessWidget {
  const MusicPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MusicPlayerCubit, MusicPlayerState, PlayerState?>(
      selector: (state) => state.currentPlayerState,
      builder: (context, currentPlayerState) {
        return GestureDetector(
          onTap: () {
            if (currentPlayerState == PlayerState.playing) {
              context.read<MusicPlayerCubit>().paused();
            } else {
              context.read<MusicPlayerCubit>().played();
            }
          },
          child: Icon(
            (currentPlayerState == PlayerState.playing)
                ? Icons.pause
                : Icons.play_arrow,
            size: 50,
          ),
        );
      },
    );
  }
}
