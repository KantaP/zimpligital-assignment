import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_event.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_state.dart';
import 'package:zimpligital_assignment/utils/format.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  Future<Map<String, dynamic>> _getMetaData(String path) async {
    final metaDataRaw = await rootBundle.loadString(path);
    final metaDataJson = jsonDecode(metaDataRaw);
    final mapped = Map<String, dynamic>.from(metaDataJson);
    return mapped;
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context , state) {
        if(state is MusicPlayerLoadSuccess) {
          return Container(
            // height: 100,
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Slider(
                    value: state.musicPlayer.playDuration.inMilliseconds > 0
                        ? (state.musicPlayer.playPosition.inMilliseconds / state.musicPlayer.playDuration.inMilliseconds).clamp(0.0, 1.0)
                        : 0.0,
                    onChanged: (value) {
                      final newPosition = state.musicPlayer.playDuration * value;
                      context.read<MusicPlayerBloc>().add(MusicPlayerSetPosition(position: newPosition));
                    },
                    onChangeEnd: (value) {
                      context.read<MusicPlayerBloc>().add(MusicPlayerSeekTo(seekToPostion: value));
                    },
                  ),
                  Text('${formatDuration(state.musicPlayer.playPosition)} / ${formatDuration(state.musicPlayer.playDuration)}'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      (state.musicPlayer.selectedMusicIndex != null)
                          ? FutureBuilder<Map<String, dynamic>>(
                            future: _getMetaData(
                              state.musicPlayer
                                  .playList[state.musicPlayer.selectedMusicIndex!]
                                  .metadataPath,
                            ),
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              if (data == null) return Text("");
                              return Expanded(
                                child: Text(
                                  data['title'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                              );
                            },
                          )
                          : Text(""),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          if (state.musicPlayer.isPlaying) {
                            context.read<MusicPlayerBloc>().add(MusicPlayerPaused());
                          } else {
                            context.read<MusicPlayerBloc>().add(MusicPlayerPlayed());
                          }
                        },
                        child: Icon(
                          (state.musicPlayer.isPlaying) ? Icons.pause : Icons.play_arrow,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}