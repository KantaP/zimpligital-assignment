import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zimpligital_assignment/providers/music_player_provider.dart';

class Player extends ConsumerWidget {
  const Player({super.key});

  Future<Map<String, dynamic>> _getMetaData(String path) async {
    final metaDataRaw = await rootBundle.loadString(path);
    final metaDataJson = jsonDecode(metaDataRaw);
    final mapped = Map<String, dynamic>.from(metaDataJson);
    return mapped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicPlayer = ref.watch(musicplayerNotifier);
    final musicPlayerNotifier = ref.read(musicplayerNotifier.notifier);

    return Container(
      height: 150,
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Slider(
              value: musicPlayer.playDuration.inMilliseconds > 0
                  ? (musicPlayer.playPosition.inMilliseconds / musicPlayer.playDuration.inMilliseconds).clamp(0.0, 1.0)
                  : 0.0,
              onChanged: (value) {
                 final newPosition = musicPlayer.playDuration * value;
                  musicPlayerNotifier.setPlayPosition(newPosition);
              },
              onChangeEnd: (value) {
                musicPlayerNotifier.seekTo(value);
              },
            ),
            Row(
              children: [
                (musicPlayer.selectedMusicIndex != null)
                    ? FutureBuilder<Map<String, dynamic>>(
                      future: _getMetaData(
                        musicPlayer
                            .playList[musicPlayer.selectedMusicIndex!]
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
                    if (musicPlayer.isPlaying) {
                      musicPlayerNotifier.pauseMusic();
                    } else {
                      musicPlayerNotifier.playMusic();
                    }
                  },
                  child: Icon(
                    (musicPlayer.isPlaying) ? Icons.pause : Icons.play_arrow,
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
}