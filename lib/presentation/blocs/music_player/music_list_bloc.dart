import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:zimpligital_assignment/domain/usecases/get_music_useCase.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicListState> {
  final GetMusicUseCase _getMusicUseCase;
  final AudioPlayer _audioPlayer;


  MusicPlayerBloc({required GetMusicUseCase getMusicUseCase , required AudioPlayer audioPlayer})
    : _getMusicUseCase = getMusicUseCase, _audioPlayer = audioPlayer,
      super(MusicPlayerDataState()) {
    on<MusicPlayerStarted>(_onStarted);
    on<MusicPlayerSelectedMusic>(_onSelectedMusic);
  }

  Future<void> _onStarted(
    MusicPlayerStarted event,
    Emitter<MusicListState> emit,
  ) async {
    emit(MusicPlayerLoadInProgress());
    final musics = await _getMusicUseCase.execute();

    
    emit(MusicPlayerDataState(musicList: musics));
  }


  Future<void> _onSelectedMusic(
    MusicPlayerSelectedMusic event,
    Emitter<MusicListState> emit,
  ) async {
    if (state is MusicPlayerDataState) {
      final currentState = state as MusicPlayerDataState;
      if(currentState.musicList.isEmpty) return;

      final musicSelected = currentState.musicList[event.musicIndex];
      final newState = currentState.copyWith(
        musicSelected: musicSelected,
      );
      _audioPlayer.pause();
      _audioPlayer.setSource(AssetSource(musicSelected.path));
      _audioPlayer.resume();
      emit(newState);
    }
  }

  
}
