
import 'package:equatable/equatable.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/entities/music_player.dart';

class MusicPlayerModel extends Equatable  {
  final List<MusicDetail> playList;
  final int? selectedMusicIndex;
  final bool isPlaying;
  final Duration playDuration;
  final Duration playPosition;

  const MusicPlayerModel({
    required this.playList,
    this.isPlaying = false,
    this.selectedMusicIndex,
    this.playDuration = Duration.zero,
    this.playPosition = Duration.zero,
  });

  MusicPlayerModel copyWith({
    bool? isPlaying,
    int? selectedMusicIndex,
    Duration? playDuration,
    Duration? playPosition,
  }) {
    return MusicPlayerModel(
      playList: playList,
      isPlaying: isPlaying ?? this.isPlaying,
      selectedMusicIndex: selectedMusicIndex ?? this.selectedMusicIndex,
      playDuration: playDuration ?? this.playDuration,
      playPosition: playPosition ?? this.playPosition,
    );
  }

  MusicPlayer toEntity() {
    return MusicPlayer(
      playList: playList,
      isPlaying: isPlaying,
      selectedMusicIndex: selectedMusicIndex,
      playDuration: playDuration,
      playPosition: playPosition,
    );
  }
  
  @override
  List<Object?> get props => [playList , isPlaying, selectedMusicIndex , playDuration , playPosition];
}
