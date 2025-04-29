import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/data/dataSources/local/local_music_datasource.dart';
import 'package:zimpligital_assignment/data/repositories/music_player_repository_Imp.dart';
import 'package:zimpligital_assignment/domain/usecases/get_music_useCase.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/music_list.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/player.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicList = MusicList();
    final player = Player();

    final localMusicDatasource = LocalMusicDatasource();
    final musicRepository = MusicPlayerRepositoryImp(localMusicDatasource);
    final getMusicUseCase = GetMusicUseCase(musicRepository);
    final audioPlayer = AudioPlayer();
    final musicPlayerCubit = MusicPlayerCubit(getMusicUseCase: getMusicUseCase, audioPlayer: audioPlayer);

    return BlocProvider.value(
      value: musicPlayerCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Simple Music Player')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Expanded(flex: 2, child: musicList), player],
          ),
        ),
      ),
    );
  }
}
