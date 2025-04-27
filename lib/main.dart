import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zimpligital_assignment/presentation/pages/music_player_screen/index.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Music App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MusicPlayerScreen(),
    );
  }
}
