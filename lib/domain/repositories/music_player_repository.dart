
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/entities/music_player.dart';

abstract class MusicPlayerRepository {
    Future<List<MusicDetail>> getMusicList();
    Future<MusicPlayer> initialMusicPlayer(List<MusicDetail> musics);
} 