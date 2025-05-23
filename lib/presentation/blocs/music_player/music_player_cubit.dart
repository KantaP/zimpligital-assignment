import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/pause_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/play_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/resume_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/seekTo_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/get_music_useCase.dart';
import 'package:zimpligital_assignment/domain/useCases/audio_player/initial_useCase.dart';
import 'package:zimpligital_assignment/presentation/models/music_player_state.dart';



class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final GetMusicUseCase _getMusicUseCase;
  final AudioPlayerPauseUsecase _pauseUseCase;
  final AudioPlayerPlayUsecase _playUseCase;
  final AudioPlayerResumeUsecase _resumeUseCase;
  final AudioPlayerSeektoUsecase _seekToUseCase;
  final InitialAudioPlayerUsecase _initialUseCase;

  MusicPlayerCubit({
    required GetMusicUseCase getMusicUseCase,
    required AudioPlayerPauseUsecase pauseUseCase,
    required AudioPlayerPlayUsecase playUseCase,
    required AudioPlayerResumeUsecase resumeUseCase,
    required AudioPlayerSeektoUsecase seekToUseCase,
    required InitialAudioPlayerUsecase initialUseCase,
  }) : _getMusicUseCase = getMusicUseCase,
        _pauseUseCase = pauseUseCase,
        _playUseCase = playUseCase,
        _resumeUseCase = resumeUseCase,
        _seekToUseCase = seekToUseCase,
        _initialUseCase = initialUseCase,
  super(MusicPlayerState()) {
    initial();
  }

  Future<void> initial() async {
    final musics = await _getMusicUseCase.execute();
    _initialUseCase.execute(
      onPlayerComplete: (_) {
        playStateChanged(PlayerState.completed);
        setPosition(Duration.zero);
      } ,
      onDurationChanged: (Duration d) {
        durationChanged(d);
      } ,
      onPositionChanged: (Duration p) {
        setPosition(p);
      } ,
      onPlayerStateChanged: (PlayerState playerState) {
        playStateChanged(playerState);
      }
    );
    emit(state.copyWith(musicList: musics));
  }

  Future<void> selectedMusic(int musicIndex) async {
    if (state.musicList.isEmpty) return;
    final musicSelected = state.musicList[musicIndex];
    _pauseUseCase.execute();
    _playUseCase.execute(AssetSource(musicSelected.path));
    emit(state.copyWith(musicSelected: musicSelected));
  }

  Future<void> playStateChanged(PlayerState playerState) async {
    emit(state.copyWith(playerState: playerState));
  }

  Future<void> durationChanged(Duration duration) async {
    emit(state.copyWith(duration: duration));
  }

  Future<void> played() async {
    _resumeUseCase.execute();
  }

  Future<void> paused() async {
    _pauseUseCase.execute();
  }

  Future<void> seekTo(double seekToPostion) async {
    final newPosition = state.currentDuration * seekToPostion;
    final newState = state.copyWith(position: newPosition);
    _seekToUseCase.execute(newPosition);
    emit(newState);
  }

  Future<void> setPosition(Duration position) async {
    emit(state.copyWith(position: position));
  }
}
