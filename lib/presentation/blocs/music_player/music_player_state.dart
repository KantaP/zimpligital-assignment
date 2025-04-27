import 'package:zimpligital_assignment/data/models/music_player_model.dart';

abstract class MusicPlayerState {}

class MusicPlayerInitial extends MusicPlayerState {}

class MusicPlayerLoadInProgress extends MusicPlayerState {}

class MusicPlayerLoadSuccess extends MusicPlayerState {
  final MusicPlayerModel musicPlayer;
  MusicPlayerLoadSuccess(this.musicPlayer);
}

class MusicPlayerDataChanged extends MusicPlayerState {
  final MusicPlayerModel musicPlayer;
  MusicPlayerDataChanged(this.musicPlayer);
}

class MusicPlayerFailure extends MusicPlayerState {
  final String message;

  MusicPlayerFailure(this.message);
}