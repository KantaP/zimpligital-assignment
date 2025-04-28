
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';

abstract class MusicPlayerRepository {
    Future<List<MusicDetail>> getMusicList();
} 