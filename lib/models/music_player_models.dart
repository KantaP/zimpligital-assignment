import 'package:audioplayers/audioplayers.dart';

class MusicDetail {
  final String path;
  final String metadataPath;

  MusicDetail({required this.path, required this.metadataPath});
}

class MusicPlayer {
  final List<MusicDetail> playList;
  final int? selectedMusicIndex;
  final bool isPlaying;
  final AudioPlayer audioPlayer;
  final Duration playDuration;
  final Duration playPosition;

  MusicPlayer({
    required this.audioPlayer,
    required this.playList,
    this.isPlaying = false,
    this.selectedMusicIndex,
    this.playDuration = Duration.zero,
    this.playPosition = Duration.zero,
  });

  MusicPlayer copyWith({bool? isPlaying, int? selectedMusicIndex, Duration? playDuration , Duration? playPosition}) {
    return MusicPlayer(
      audioPlayer: audioPlayer,
      playList: playList,
      isPlaying: isPlaying ?? this.isPlaying,
      selectedMusicIndex: selectedMusicIndex ?? this.selectedMusicIndex,
      playDuration: playDuration ?? this.playDuration,
      playPosition: playPosition ?? this.playPosition,
    );
  }
}