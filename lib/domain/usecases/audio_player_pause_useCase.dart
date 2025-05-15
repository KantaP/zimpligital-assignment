import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class AudioPlayerPauseUsecase {
  final MusicPlayerRepository repository;
  AudioPlayerPauseUsecase(this.repository);

  void execute() {
    repository.pause();
  }
}