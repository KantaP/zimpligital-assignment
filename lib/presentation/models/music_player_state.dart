import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';

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