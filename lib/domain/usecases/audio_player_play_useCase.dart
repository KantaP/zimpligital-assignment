import 'package:audioplayers/audioplayers.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class AudioPlayerPlayUsecase {
  final MusicPlayerRepository repository;
  AudioPlayerPlayUsecase(this.repository);

  void execute(Source source) {
    repository.play(source);
  }
}