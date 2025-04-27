import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_state.dart';

class TrackingSlider extends StatelessWidget {
  const TrackingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingPlayerBloc, TrackingPlayerState>(
      builder: (context, state) {
        if (state is TrackingPlayerDataState) {
          return Slider(
            value:
                state.currentDuration.inMilliseconds > 0
                    ? (state.currentPosition.inMilliseconds /
                            state.currentDuration.inMilliseconds)
                        .clamp(0.0, 1.0)
                    : 0.0,
            onChanged: (value) {
              final newPosition = state.currentDuration * value;
              context.read<TrackingPlayerBloc>().add(
                MusicPlayerSetPosition(position: newPosition),
              );
            },
            onChangeEnd: (value) {
              context.read<TrackingPlayerBloc>().add(
                MusicPlayerSeekTo(seekToPostion: value),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
