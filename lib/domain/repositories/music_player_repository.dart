
import 'package:audioplayers/audioplayers.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';

abstract class MusicPlayerRepository {
    Future<List<MusicDetail>> getMusicList();
    
    void initialAudioPlayer({
      required Function(void)? onPlayerComplete,
      required Function(Duration)? onDurationChanged,
      required Function(Duration)? onPositionChanged,
      required Function(PlayerState)? onPlayerStateChanged,
    });
    void pause();
    void play(Source source);
    void resume();
    void seekTo(Duration seekTo);
} 