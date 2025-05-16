import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class AudioPlayerResumeUsecase {
  final MusicPlayerRepository repository;
  AudioPlayerResumeUsecase(this.repository);

  void execute() {
    repository.resume();
  }
}