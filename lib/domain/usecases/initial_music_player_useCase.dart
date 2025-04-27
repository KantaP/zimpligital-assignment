import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/entities/music_player.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class InitialMusicPlayerUseCase {
  final MusicPlayerRepository repository;
  InitialMusicPlayerUseCase(this.repository);

  Future<MusicPlayer> execute(List<MusicDetail> musics) async {
    return await repository.initialMusicPlayer(musics);
  }
}
       