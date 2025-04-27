import 'music_detail.dart';

class MusicPlayer {
  final List<MusicDetail> playList;
  final int? selectedMusicIndex;
  final bool isPlaying;
  final Duration playDuration;
  final Duration playPosition;

  MusicPlayer({
    required this.playList,
    this.isPlaying = false,
    this.selectedMusicIndex,
    this.playDuration = Duration.zero,
    this.playPosition = Duration.zero,
  });
}