import 'package:flutter/material.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/music_play_button.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/song_selected_text.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/tracking_slider.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/widgets/tracking_text.dart';
class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerButton = MusicPlayButton();
    final songSelectedText = SongSelectedText();
    final trackingText = TrackingText();
    final trackingSlider = TrackingSlider();

    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            trackingSlider,
            trackingText,
            SizedBox(height: 10),
            Row(
              children: [
                songSelectedText,
                SizedBox(width: 10),
                musicPlayerButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
