
abstract class MusicPlayerEvent {}

class MusicPlayerStarted extends MusicPlayerEvent {}
class MusicPlayerInitial extends MusicPlayerEvent {}
class MusicPlayerSelectedMusic extends MusicPlayerEvent {
  final int musicIndex;
  MusicPlayerSelectedMusic({required this.musicIndex});
}




