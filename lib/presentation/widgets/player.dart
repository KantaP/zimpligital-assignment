import 'package:flutter/material.dart';
import 'package:zimpligital_assignment/presentation/widgets/music_play_button.dart';
import 'package:zimpligital_assignment/presentation/widgets/song_selected_text.dart';
import 'package:zimpligital_assignment/presentation/widgets/tracking_slider.dart';
import 'package:zimpligital_assignment/presentation/widgets/tracking_text.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TrackingSlider(),
            TrackingText(),
            const SizedBox(height: 10),
            Row(
              children: [
                SongSelectedText(),
                const SizedBox(width: 10),
                MusicPlayButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
