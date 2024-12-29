import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';
import 'package:livekirtanapp/screens/splashscreen.dart'; // Import just_audio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Kirtan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
      // const MyHomePage(title: 'Live Kirtan'),
    );
  }
}
