import 'package:flutter/material.dart';
import 'package:livekirtanapp/song.dart';
import 'package:livekirtanapp/widgets/song_tile.dart';

class  KirtanListScreen extends StatelessWidget {
   KirtanListScreen({super.key});
  final List<Song> songs = [
    Song(title: "Raam Naam Jaap", duration: "2min", day: "Day 1", path: "assets/songs/raam_naam_jaap.mp3"),
    Song(title: "Mahamrityunjaya", duration: "3mins", day: "Day 2", path: "assets/songs/mahamrityunjaya.mp3"),
    Song(title: "Om Namah Sivaya", duration: "5mins", day: "Day 3", path: "assets/songs/om_namah_sivaya.mp3"),
    Song(title: "Gayatri Mantra", duration: "4mins", day: "Day 4", path: "assets/songs/gayatri_mantra.mp3"),
    Song(title: "Om Mani Padme Hum", duration: "9mins", day: "Day 5", path: "assets/songs/om_mani_padme_hum.mp3"),
    Song(title: "Hare Krishna", duration: "1:30min", day: "Day 6", path: "assets/songs/hare_krishna.mp3"),
    Song(title: "Om Namo Narayanaya", duration: "1:30min", day: "Day 7", path: "assets/songs/om_namo_narayanaya.mp3"),
    Song(title: "Raam Naam Jaap", duration: "1:30min", day: "Day 8", path: "assets/songs/raam_naam_jaap.mp3"),
    Song(title: "Mahamrityunjaya", duration: "1:30min", day: "Day 9", path: "assets/songs/mahamrityunjaya.mp3"),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return SongTile(song: songs[index]);
        },
      ),
    );
  }
}
