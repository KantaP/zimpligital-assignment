import 'package:equatable/equatable.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';

abstract class MusicListState extends Equatable {
  const MusicListState();
}

class MusicPlayerLoadInProgress extends MusicListState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MusicPlayerDataState extends MusicListState {
  final List<MusicDetail> musicList;
  final MusicDetail? musicSelected;
  const MusicPlayerDataState({this.musicList = const [] , this.musicSelected});
  
  @override
  List<Object?> get props => [musicList , musicSelected];

  MusicPlayerDataState copyWith({MusicDetail? musicSelected, List<MusicDetail>? musicList}) {
    return MusicPlayerDataState(
      musicList: musicList ?? this.musicList,
      musicSelected: musicSelected ?? this.musicSelected,
    );
  }
}
