import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';
import 'package:zimpligital_assignment/presentation/models/music_player_state.dart';
import 'package:zimpligital_assignment/presentation/utils/duration_ext.dart';

class TrackingText extends StatelessWidget {
  const TrackingText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MusicPlayerCubit, MusicPlayerState , List<Duration>>(
      selector: (state) => [state.currentDuration , state.currentPosition],
      builder: (context, durations) {
         return  Text('${durations[1].formatDuration()} / ${durations[0].formatDuration()}');
      },
    );
  }
}
