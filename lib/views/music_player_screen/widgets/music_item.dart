import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zimpligital_assignment/providers/music_player_provider.dart';

import '../../../models/music_player_models.dart';

class MusicItem extends ConsumerStatefulWidget {
  const MusicItem({super.key, required this.music, required this.musicIndex});

  final int musicIndex;
  final MusicDetail music;

  @override
  ConsumerState<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends ConsumerState<MusicItem> {
  Duration? _duration;
  String? _title;
  String? _album;
  String? _artist;

  @override
  void initState() {
    super.initState();
    _getMetaData();
  }

  void _getMetaData() async {
    final metaDataRaw = await rootBundle.loadString(widget.music.metadataPath);
    final metaDataJson = jsonDecode(metaDataRaw);
    setState(() {
      _duration = Duration(seconds: metaDataJson['duration'] ?? 0);
      _title = metaDataJson['title'] ?? "";
      _artist = metaDataJson['artist'] ?? "";
      _album = metaDataJson['album'] ?? "";
    });
  }

  String _formatDuration(Duration? d) {
    if (d == null) return "--:--";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$minutes:$seconds";
  }

  void _handleOnTap() {
    final musicPlayerNotifier = ref.read(musicplayerNotifier.notifier);
    musicPlayerNotifier.pauseMusic();
    musicPlayerNotifier.selectMusic(widget.musicIndex);
    musicPlayerNotifier.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child: ListTile(
        title: Text(
          "$_title ${(_artist != null && _artist!.isNotEmpty) ? "- $_artist" : ""}",
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          "$_album",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        trailing: Text(_formatDuration(_duration)),
      ),
    );
  }
}
