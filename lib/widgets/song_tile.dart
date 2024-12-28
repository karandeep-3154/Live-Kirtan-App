import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:livekirtanapp/song.dart';

class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.play_circle_fill, color: Colors.orange, size: 40),
        onPressed: () => playSong(song.path),
      ),
      title: Text(
        song.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text("${song.duration} | ${song.day}"),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      horizontalTitleGap: 10,
    );
  }

  void playSong(String path) async {
    final player = AudioPlayer();
    await player.setAudioSource(AudioSource.uri(Uri.parse(path)));
    await player.play();
  }
}