import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/tracking_player_state.dart';

class TrackingPlayerBloc extends Bloc<TrackingPlayerEvent, TrackingPlayerState>{
  final AudioPlayer _audioPlayer;

  TrackingPlayerBloc({required AudioPlayer audioPlayer})
  : _audioPlayer = audioPlayer, 
  super(TrackingPlayerDataState()) {
     on<MusicPlayerPlayed>(_onPlayed);
    on<MusicPlayerPaused>(_onPaused);
    on<MusicPlayerSeekTo>(_onSeekTo);
    on<MusicPlayerSetPosition>(_onSetPosition);
    on<MusicPlayerPlayStateChanged>(_onPlayStateChanged);
    on<MusicPlayerDurationChanged>(_onDurationChanged);
    
    _audioPlayer.onPlayerComplete.listen((_) {
      add(MusicPlayerSetPosition(position: Duration.zero));
      add(MusicPlayerDurationChanged(duration: Duration.zero));
      add(MusicPlayerPlayStateChanged(playerState: PlayerState.completed));
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      add(MusicPlayerDurationChanged(duration: d));
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      add(MusicPlayerSetPosition(position: p));
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState playState) {
      add(MusicPlayerPlayStateChanged(playerState: playState));
    });
  }


  Future<void> _onPlayStateChanged(MusicPlayerPlayStateChanged event, Emitter<TrackingPlayerState> emit) async {
    if(_audioPlayer.source == null) return;
    if(state is TrackingPlayerDataState) {
      final newState = (state as TrackingPlayerDataState).copyWith(
        playerState: event.playerState
      );
      emit(newState);
    }
  }

  Future<void> _onDurationChanged(MusicPlayerDurationChanged event , Emitter<TrackingPlayerState> emit) async {
    if(state is TrackingPlayerDataState) {
      final newState = (state as TrackingPlayerDataState).copyWith(duration: event.duration);
      emit(newState);
    }
  }

  Future<void> _onPlayed(
    MusicPlayerPlayed event,
    Emitter<TrackingPlayerState> emit,
  ) async {
    _audioPlayer.resume();
  }

  Future<void> _onPaused(
    MusicPlayerPaused event,
    Emitter<TrackingPlayerState> emit,
  ) async {
    _audioPlayer.pause();
  }

  Future<void> _onSeekTo(
    MusicPlayerSeekTo event,
    Emitter<TrackingPlayerState> emit,
  ) async {
    if (state is TrackingPlayerDataState) {
      final currentState = state as TrackingPlayerDataState;
      final newPosition =
          currentState.currentDuration * event.seekToPostion;
      final newState = currentState.copyWith(
        position: newPosition,
      );
      _audioPlayer.seek(newPosition);
      emit(newState);
    }
  }

  Future<void> _onSetPosition(
    MusicPlayerSetPosition event,
    Emitter<TrackingPlayerState> emit,
  ) async {
    if (state is TrackingPlayerDataState) {
      final currentState = state as TrackingPlayerDataState;
      final newState = currentState.copyWith(
        position: event.position,
      );
      emit(newState);
    }
  }

}