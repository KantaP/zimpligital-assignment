import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/usecases/get_music_useCase.dart';

class MusicPlayerState extends Equatable {
  final List<MusicDetail> musicList;
  final MusicDetail? musicSelected;
  final Duration currentDuration;
  final Duration currentPosition;
  final PlayerState? currentPlayerState;
  const MusicPlayerState({
    this.musicList = const [],
    this.musicSelected,
    this.currentDuration = Duration.zero,
    this.currentPosition = Duration.zero,
    this.currentPlayerState,
  });

  @override
  List<Object?> get props => [
    musicList,
    musicSelected,
    currentDuration,
    currentPosition,
    currentPlayerState,
  ];

  MusicPlayerState copyWith({
    MusicDetail? musicSelected,
    List<MusicDetail>? musicList,
    Duration? duration,
    Duration? position,
    PlayerState? playerState,
  }) {
    return MusicPlayerState(
      musicList: musicList ?? this.musicList,
      musicSelected: musicSelected ?? this.musicSelected,
      currentDuration: duration ?? currentDuration,
      currentPosition: position ?? currentPosition,
      currentPlayerState: playerState ?? currentPlayerState,
    );
  }
}

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final GetMusicUseCase _getMusicUseCase;
  final AudioPlayer _audioPlayer;

  MusicPlayerCubit({
    required GetMusicUseCase getMusicUseCase,
    required AudioPlayer audioPlayer,
  }) : _getMusicUseCase = getMusicUseCase,
       _audioPlayer = audioPlayer, super(MusicPlayerState()) {

    
    initial();

    _audioPlayer.onPlayerComplete.listen((_) {
      playStateChanged(PlayerState.completed);
      setPosition(Duration.zero);
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      durationChanged(d);
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setPosition(p);
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) {
      playStateChanged(playerState);
    });
  }

  Future<void> initial() async {
    final musics = await _getMusicUseCase.execute();
    emit(state.copyWith(musicList: musics));
  }

  Future<void> selectedMusic(int musicIndex) async {
    if (state.musicList.isEmpty) return;
    final musicSelected = state.musicList[musicIndex];
    _audioPlayer.pause();
    _audioPlayer.play(AssetSource(musicSelected.path));
    emit(state.copyWith(musicSelected: musicSelected));
  }

  Future<void> playStateChanged(PlayerState playerState) async {
    if (_audioPlayer.source == null) return;
    emit(state.copyWith(playerState: playerState));
  }

  Future<void> durationChanged(Duration duration) async {
    emit(state.copyWith(duration: duration));
  }

  Future<void> played() async {
    _audioPlayer.resume();
  }

  Future<void> paused() async {
    _audioPlayer.pause();
  }

  Future<void> seekTo(double seekToPostion) async {
    final newPosition = state.currentDuration * seekToPostion;
    final newState = state.copyWith(position: newPosition);
    _audioPlayer.seek(newPosition);
    emit(newState);
  }

  Future<void> setPosition(Duration position) async {
    emit(state.copyWith(position: position));
  }
}
