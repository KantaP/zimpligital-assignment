import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_state.dart';

class MusicPlayButton extends StatelessWidget {
  const MusicPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingPlayerBloc, TrackingPlayerState>(
      builder: (context, state) {
        if (state is TrackingPlayerDataState) {
          final currentState = state;
          return GestureDetector(
            onTap: () {
              
              if (currentState.currentPlayerState == PlayerState.playing) {
                context.read<TrackingPlayerBloc>().add(MusicPlayerPaused());
              } else {
                context.read<TrackingPlayerBloc>().add(MusicPlayerPlayed());
              }
            },
            child: Icon(
              (currentState.currentPlayerState == PlayerState.playing)
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 50,
            ),
          );
        }
        return Container();
      },
    );
  }
}
