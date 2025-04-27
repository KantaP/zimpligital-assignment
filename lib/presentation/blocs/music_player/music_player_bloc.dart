import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:zimpligital_assignment/data/models/music_player_model.dart';
import 'package:zimpligital_assignment/domain/usecases/get_music_useCase.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final GetMusicUseCase _getMusicUseCase;

  final audioPlayer = AudioPlayer();

  MusicPlayerBloc({required GetMusicUseCase getMusicUseCase})
    : _getMusicUseCase = getMusicUseCase,
      super(MusicPlayerInitial()) {
    on<MusicPlayerStarted>(_onStarted);
    on<MusicPlayerPlayed>(_onPlayed);
    on<MusicPlayerPaused>(_onPaused);
    on<MusicPlayerSelectedMusic>(_onSelectedMusic);
    on<MusicPlayerSeekTo>(_onSeekTo);
    on<MusicPlayerSetPosition>(_onSetPosition);
    on<MusicPlayerPlayStateChanged>(_onPlayStateChanged);
    on<MusicPlayerDurationChanged>(_onDurationChanged);
  }

  Future<void> _onStarted(
    MusicPlayerStarted event,
    Emitter<MusicPlayerState> emit,
  ) async {
    emit(MusicPlayerLoadInProgress());
    final musics = await _getMusicUseCase.execute();
    
    audioPlayer.onPlayerComplete.listen((_) {
      add(MusicPlayerPlayStateChanged(playerState: PlayerState.completed));
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      add(MusicPlayerDurationChanged(duration: d));
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      add(MusicPlayerSetPosition(position: p));
    });

    audioPlayer.onPlayerStateChanged.listen((PlayerState playState) {
      add(MusicPlayerPlayStateChanged(playerState: playState));
    });

    final model = MusicPlayerModel(playList: musics);
    emit(MusicPlayerLoadSuccess(model));
  }

  Future<void> _onPlayStateChanged(MusicPlayerPlayStateChanged event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      final newState = currentState.musicPlayer.copyWith(isPlaying: event.playerState == PlayerState.playing);
      emit(MusicPlayerLoadSuccess(newState));
    }
  }

  Future<void> _onDurationChanged(MusicPlayerDurationChanged event , Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      final newState = currentState.musicPlayer.copyWith(playDuration: event.duration);
      emit(MusicPlayerLoadSuccess(newState));
    }
  }

  Future<void> _onPlayed(
    MusicPlayerPlayed event,
    Emitter<MusicPlayerState> emit,
  ) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      if (currentState.musicPlayer.selectedMusicIndex == null) return;
      
      audioPlayer.setSource(
        AssetSource(
          currentState
              .musicPlayer
              .playList[currentState.musicPlayer.selectedMusicIndex!]
              .path,
        ),
      );
      audioPlayer.resume();
    }
  }

  Future<void> _onPaused(
    MusicPlayerPaused event,
    Emitter<MusicPlayerState> emit,
  ) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      if (currentState.musicPlayer.isPlaying == false) return;
      audioPlayer.pause();
    }
  }

  Future<void> _onSelectedMusic(
    MusicPlayerSelectedMusic event,
    Emitter<MusicPlayerState> emit,
  ) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      final newState = currentState.musicPlayer.copyWith(
        selectedMusicIndex: event.musicIndex,
      );
      emit(MusicPlayerLoadSuccess(newState));
    }
  }

  Future<void> _onSeekTo(
    MusicPlayerSeekTo event,
    Emitter<MusicPlayerState> emit,
  ) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      final newPosition =
          currentState.musicPlayer.playDuration * event.seekToPostion;
      final newState = currentState.musicPlayer.copyWith(
        playPosition: newPosition,
      );
      audioPlayer.seek(newPosition);
      emit(MusicPlayerLoadSuccess(newState));
    }
  }

  Future<void> _onSetPosition(
    MusicPlayerSetPosition event,
    Emitter<MusicPlayerState> emit,
  ) async {
    if (state is MusicPlayerLoadSuccess) {
      final currentState = state as MusicPlayerLoadSuccess;
      final newState = currentState.musicPlayer.copyWith(
        playPosition: event.position,
      );
      emit(MusicPlayerLoadSuccess(newState));
    }
  }
}
