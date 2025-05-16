import 'package:flutter/foundation.dart';
import 'package:zimpligital_assignment/data/dataSources/local/local_music_datasource.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerRepositoryImp extends MusicPlayerRepository {
  final LocalMusicDatasource _localMusicDatasource;
  final AudioPlayer _audioPlayer;

  MusicPlayerRepositoryImp({
    required LocalMusicDatasource localMusicDatasource,
  }) : _localMusicDatasource = localMusicDatasource,
        _audioPlayer = AudioPlayer();

  @override
  Future<List<MusicDetail>> getMusicList() async {
    try {
      return _localMusicDatasource.getMusicList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  @override
  void pause() {
    _audioPlayer.pause();
  }

  @override
  void play(Source source) {
    _audioPlayer.play(source);
  }

  @override
  void resume() {
    _audioPlayer.resume();
  }

  @override
  void seekTo(Duration seekTo) {
    _audioPlayer.seek(seekTo);
  }

  @override
  void initialAudioPlayer({
    required Function(void)? onPlayerComplete,
    required Function(Duration)? onDurationChanged,
    required Function(Duration)? onPositionChanged,
    required Function(PlayerState)? onPlayerStateChanged,
  }) {
    _audioPlayer.onPlayerComplete.listen(onPlayerComplete);

    _audioPlayer.onDurationChanged.listen(onDurationChanged);

    _audioPlayer.onPositionChanged.listen(onPositionChanged);

    _audioPlayer.onPlayerStateChanged.listen(onPlayerStateChanged);
  }
}
