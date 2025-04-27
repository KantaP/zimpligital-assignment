import 'package:audioplayers/audioplayers.dart';

abstract class MusicPlayerEvent {}

class MusicPlayerStarted extends MusicPlayerEvent {}
class MusicPlayerPlayed extends MusicPlayerEvent {}
class MusicPlayerPaused extends MusicPlayerEvent {}
class MusicPlayerSelectedMusic extends MusicPlayerEvent {
  final int musicIndex;
  MusicPlayerSelectedMusic({required this.musicIndex});
}
class MusicPlayerSeekTo extends MusicPlayerEvent {
  final double seekToPostion;
  MusicPlayerSeekTo({required this.seekToPostion});
}
class MusicPlayerSetPosition extends MusicPlayerEvent {
  final Duration position;
  MusicPlayerSetPosition({required this.position});
}

class MusicPlayerDurationChanged extends MusicPlayerEvent {
  final Duration duration;
  MusicPlayerDurationChanged({required this.duration});
}

class MusicPlayerPlayStateChanged extends MusicPlayerEvent {
  final PlayerState playerState;
  MusicPlayerPlayStateChanged({required this.playerState});
}



