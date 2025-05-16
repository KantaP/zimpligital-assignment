import 'package:audioplayers/audioplayers.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class InitialAudioPlayerUsecase {
  final MusicPlayerRepository repository;
  InitialAudioPlayerUsecase(this.repository);

  void execute({
    required Function(void)? onPlayerComplete,
    required Function(Duration)? onDurationChanged,
    required Function(Duration)? onPositionChanged,
    required Function(PlayerState)? onPlayerStateChanged,
  }) {
    repository.initialAudioPlayer(
      onPlayerComplete: onPlayerComplete,
      onDurationChanged: onDurationChanged,
      onPositionChanged: onPositionChanged,
      onPlayerStateChanged: onPlayerStateChanged,
    );
  }
}
