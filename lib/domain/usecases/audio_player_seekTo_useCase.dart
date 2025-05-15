import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class AudioPlayerSeektoUsecase {
  final MusicPlayerRepository repository;
  AudioPlayerSeektoUsecase(this.repository);

  void execute(Duration seekTo) {
    repository.seekTo(seekTo);
  }
}