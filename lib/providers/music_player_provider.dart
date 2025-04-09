import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zimpligital_assignment/models/music_player_models.dart';

final List<MusicDetail> musicList = [
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

class MusicPlayerNotifier extends StateNotifier<MusicPlayer> {
  MusicPlayerNotifier()
    : super(MusicPlayer(audioPlayer: AudioPlayer(), playList: musicList));

  
  void initMusicPlayer() {
    state.audioPlayer.onPlayerComplete.listen((_) {
      state = state.copyWith(isPlaying: false);
    });
    state.audioPlayer.onDurationChanged.listen((Duration d) {
      state = state.copyWith(playDuration: d);
    });

    state.audioPlayer.onPositionChanged.listen((Duration p) {
      state = state.copyWith(playPosition: p);
    });

    state.audioPlayer.onPlayerStateChanged.listen((PlayerState playState) {
      state = state.copyWith(
        isPlaying: playState == PlayerState.playing
      );
    });
  }

  void playMusic() async {
    if (state.selectedMusicIndex == null) return;
    await state.audioPlayer.play(
      AssetSource(state.playList[state.selectedMusicIndex!].path),
    );
    state = state.copyWith(isPlaying: true);
  }

  void pauseMusic() async {
    await state.audioPlayer.pause();
    state = state.copyWith(isPlaying: false);
  }

  void selectMusic(int index) {
    state = state.copyWith(selectedMusicIndex: index);
  }

  void setPlayPosition(Duration p){
    state = state.copyWith(playPosition: p);
  }

  void seekTo(double value) async {
    final newPosition = state.playDuration * value;
    await state.audioPlayer.seek(newPosition);
  }
  
}

final musicplayerNotifier =
    StateNotifierProvider<MusicPlayerNotifier, MusicPlayer>(
      (ref) => MusicPlayerNotifier(),
    );
