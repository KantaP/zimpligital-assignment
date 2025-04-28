import 'package:flutter/foundation.dart';
import 'package:zimpligital_assignment/data/dataSources/local/local_music_datasource.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/domain/repositories/music_player_repository.dart';

class MusicPlayerRepositoryImp extends MusicPlayerRepository {

  final LocalMusicDatasource localMusicDatasource;

  MusicPlayerRepositoryImp(this.localMusicDatasource);
  
  @override
  Future<List<MusicDetail>> getMusicList() async {
    try {
      return localMusicDatasource.getMusicList();
    }catch(e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}