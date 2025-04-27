import 'package:audioplayers/audioplayers.dart';

abstract class TrackingPlayerEvent {}


class MusicPlayerPlayed extends TrackingPlayerEvent {}
class MusicPlayerPaused extends TrackingPlayerEvent {}
class MusicPlayerSetPosition extends TrackingPlayerEvent {
  final Duration position;
  MusicPlayerSetPosition({required this.position});
}

class MusicPlayerDurationChanged extends TrackingPlayerEvent {
  final Duration duration;
  MusicPlayerDurationChanged({required this.duration});
}

class MusicPlayerSeekTo extends TrackingPlayerEvent {
  final double seekToPostion;
  MusicPlayerSeekTo({required this.seekToPostion});
}

class MusicPlayerPlayStateChanged extends TrackingPlayerEvent {
  final PlayerState playerState;
  MusicPlayerPlayStateChanged({required this.playerState});
}