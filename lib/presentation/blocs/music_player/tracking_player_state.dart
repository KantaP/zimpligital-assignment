import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';

abstract class TrackingPlayerState extends Equatable {
  const TrackingPlayerState();
}

class TrackingPlayerDataState extends TrackingPlayerState {
  final Duration currentDuration;
  final Duration currentPosition;
  final PlayerState? currentPlayerState;
  const TrackingPlayerDataState({
    this.currentDuration = Duration.zero,
    this.currentPosition = Duration.zero,
    this.currentPlayerState,
  });

  @override
  List<Object?> get props => [currentDuration, currentPosition, currentPlayerState];

  TrackingPlayerDataState copyWith({
    Duration? duration,
    Duration? position,
    PlayerState? playerState,
  }) {
    return TrackingPlayerDataState(
      currentDuration: duration ?? currentDuration,
      currentPosition: position ?? currentPosition,
      currentPlayerState: playerState ?? currentPlayerState,
    );
  }
}
