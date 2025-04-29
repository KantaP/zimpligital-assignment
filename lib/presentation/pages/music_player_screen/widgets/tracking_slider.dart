import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';

class TrackingSlider extends StatelessWidget {
  const TrackingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MusicPlayerCubit, MusicPlayerState, List<Duration>>(
      selector: (state) => [state.currentDuration, state.currentPosition],
      builder: (context, durations) {
        return Slider(
          value:
              durations[0].inMilliseconds > 0
                  ? (durations[1].inMilliseconds / durations[0].inMilliseconds)
                      .clamp(0.0, 1.0)
                  : 0.0,
          onChanged: (value) {
            final newPosition = durations[0] * value;
            context.read<MusicPlayerCubit>().setPosition(newPosition);
          },
          onChangeEnd: (value) {
            context.read<MusicPlayerCubit>().seekTo(value);
          },
        );
      },
    );
  }
}
