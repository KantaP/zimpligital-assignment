import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_bloc.dart';
import 'package:zimpligital_assignment/presentation/blocs/music_player/music_list_state.dart';

class SongSelectedText extends StatelessWidget {
  const SongSelectedText({super.key});

   Future<Map<String, dynamic>> _getMetaData(String path) async {
    final metaDataRaw = await rootBundle.loadString(path);
    final metaDataJson = jsonDecode(metaDataRaw);
    final mapped = Map<String, dynamic>.from(metaDataJson);
    return mapped;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicListState>(
      builder: (context, state) {
        if (state is MusicPlayerDataState) {
          if(state.musicSelected == null) return Container();
          return FutureBuilder<Map<String, dynamic>>(
            future: _getMetaData(
              state
                  .musicSelected!
                  .metadataPath,
            ),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) return Text("");
              return Expanded(
                child: Text(
                  data['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
