import 'package:zimpligital_assignment/domain/entities/music_detail.dart';

class LocalMusicDatasource {
  Future<List<MusicDetail>> getMusicList() async {
    return [
      MusicDetail(
        path: "audio/dead-to-me.mp3",
        metadataPath: "assets/audio/dead-to-me.json",
      ),
      MusicDetail(
        path: "audio/fractal.mp3",
        metadataPath: "assets/audio/fractal.json",
      ),
      MusicDetail(
        path: "audio/hahaha.mp3",
        metadataPath: "assets/audio/hahaha.json",
      ),
      MusicDetail(
        path: "audio/happy-to-be-happy.mp3",
        metadataPath: "assets/audio/happy-to-be-happy.json",
      ),
      MusicDetail(
        path: "audio/overflow.mp3",
        metadataPath: "assets/audio/overflow.json",
      ),
      MusicDetail(
        path: "audio/hot-for-a-min.mp3",
        metadataPath: "assets/audio/hot-for-a-min.json",
      ),
      MusicDetail(
        path: "audio/papi-beat.mp3",
        metadataPath: "assets/audio/papi-beat.json",
      ),
      MusicDetail(
        path: "audio/straight-up.mp3",
        metadataPath: "assets/audio/straight-up.json",
      ),
      MusicDetail(
        path: "audio/synergy.mp3",
        metadataPath: "assets/audio/synergy.json",
      ),
    ];
  }
}
