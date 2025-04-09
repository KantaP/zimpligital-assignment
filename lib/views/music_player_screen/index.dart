import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zimpligital_assignment/providers/music_player_provider.dart';
import 'package:zimpligital_assignment/views/music_player_screen/widgets/music_item.dart';
import 'package:zimpligital_assignment/views/music_player_screen/widgets/player.dart';

class MusicPlayerScreen extends ConsumerStatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  ConsumerState<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends ConsumerState<MusicPlayerScreen> {
  @override
  void initState() {
    super.initState();
    final musicPlayerNotifier = ref.read(musicplayerNotifier.notifier);
    musicPlayerNotifier.initMusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayer = ref.watch(musicplayerNotifier);
    return Scaffold(
      appBar: AppBar(title: Text('Simple Music Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder:
                    (context, index) => MusicItem(
                      key: Key("music_$index"),
                      music: musicPlayer.playList[index],
                      musicIndex: index,
                    ),
                itemCount: musicPlayer.playList.length,
              ),
            ),
            Player(),
          ],
        ),
      ),
    );
  }
}
