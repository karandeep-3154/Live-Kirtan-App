import 'package:flutter/material.dart';
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';
import 'package:livekirtanapp/song_class.dart'; // Ensure this import is correct


class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    print(song.subtitle);
    return ListTile(
      onTap: () {
        // Navigate to the AudioPlayerScreen with the song's path and title
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AudioPlayerWidget(
                  liveStreamUrl: song.path,
                  title: song.title,
                  subtitle: song.subtitle,
                  location: song.location,
                  imageAssetPath: song.imageAssetPath,
                  isRecorded: false,
                ),
          ),
        );
      },
      // leading: Icon(
      //     Icons.play_circle_fill, color: Colors.orange, size: 40
      //
      // ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius for more or less rounding
        child: Image.asset(
          song.imageAssetPath, // Ensure this is the correct path to your asset image
          width: 45,
          height:45,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        song.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      // subtitle: Row(
      //   children: [
      //     Text(song.subtitle)
      //   ],
      // ),
      subtitle: Text(" ${song.location}"),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      horizontalTitleGap: 10,
    );
  }
}
