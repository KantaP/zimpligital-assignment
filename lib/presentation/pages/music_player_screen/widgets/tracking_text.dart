import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_state.dart';
import 'package:zimpligital_assignment/utils/format.dart';

class TrackingText extends StatelessWidget {
  const TrackingText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingPlayerBloc, TrackingPlayerState>(
      builder: (context, state) {
        if(state is TrackingPlayerDataState){
          return  Text('${formatDuration(state.currentPosition)} / ${formatDuration(state.currentDuration)}');
        }
        return Text("");
      },
    );
  }
}
