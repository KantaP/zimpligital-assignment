import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class GetMusicUseCase {
  final MusicPlayerRepository repository;

  GetMusicUseCase( this.repository);

  Future<List<MusicDetail>> execute() async {
    return await repository.getMusicList();
  }
}