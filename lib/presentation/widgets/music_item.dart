import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/domain/entities/music_detail.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_player_cubit.dart';
import 'package:zimpligital_assignment/common/utils/duration_ext.dart';


class MusicItem extends StatefulWidget {
  const MusicItem({super.key, required this.music, required this.musicIndex});

  final int musicIndex;
  final MusicDetail music;

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
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


  void _handleOnTap(BuildContext context) async{
    context.read<MusicPlayerCubit>().selectedMusic(widget.musicIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOnTap(context),
      child: ListTile(
        title: Text(
          "$_title ${(_artist != null && _artist!.isNotEmpty) ? "- $_artist" : ""}",
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          "$_album",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
        trailing: Text( (_duration != null) ?  _duration!.formatDuration() : '--:--'),
      ),
    );
  }
}
