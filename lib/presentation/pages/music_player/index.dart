import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/data/dataSources/local/local_music_datasource.dart';
import 'package:zimpligital_assignment/data/repositories/music_player_repository_Imp.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/pause_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/play_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/resume_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/seekTo_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/get_music_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/initial_useCase.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';
import 'package:zimpligital_assignment/presentation/widgets/music_list.dart';
import 'package:zimpligital_assignment/presentation/widgets/player.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localMusicDatasource = LocalMusicDatasource();
    final musicRepository = MusicPlayerRepositoryImp(
      localMusicDatasource: localMusicDatasource,
    );

    final getMusicUseCase = GetMusicUseCase(musicRepository);
    final audioPlayUseCase = AudioPlayerPlayUsecase(musicRepository);
    final audioPauseUseCase = AudioPlayerPauseUsecase(musicRepository);
    final audioResumeUseCase = AudioPlayerResumeUsecase(musicRepository);
    final audioSeekToUseCase = AudioPlayerSeektoUsecase(musicRepository);
    final initialAudioUseCase = InitialAudioPlayerUsecase(musicRepository);
    final musicPlayerCubit = MusicPlayerCubit(
      getMusicUseCase: getMusicUseCase,
      playUseCase: audioPlayUseCase,
      pauseUseCase: audioPauseUseCase,
      resumeUseCase: audioResumeUseCase,
      seekToUseCase: audioSeekToUseCase,
      initialUseCase: initialAudioUseCase,
    );

    return BlocProvider.value(
      value: musicPlayerCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Simple Music Player')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Expanded(flex: 2, child: MusicList()), Player()],
          ),
        ),
      ),
    );
  }
}
