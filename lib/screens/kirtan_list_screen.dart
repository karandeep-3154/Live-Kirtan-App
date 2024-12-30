import 'package:flutter/material.dart';
import 'package:livekirtanapp/screens/song_tile.dart';
import 'package:livekirtanapp/song_class.dart';
import 'package:share_plus/share_plus.dart';

class KirtanListScreen extends StatelessWidget {
  KirtanListScreen({super.key});

  final List<Song> songs = [
    Song(
        title: "Sri Harminder Sahib Live Kirtan",  imageAssetPath:"assets/darbarsahib.jpg", path: "https://live.sgpc.net:8444/;", subtitle: "Harminder Sahib (HD)", location: "Sri Amritsar Sahib, Punjab, India"),
    Song(
        title: "Sri Harminder Sahib Hukamnamma",  imageAssetPath:"assets/hukamnamma.jpg", path: "https://old.sgpc.net/hukumnama/jpeg%20hukamnama/hukamnama.mp3?_=1&1735487096181", subtitle: "Harminder Sahib (HD)", location: "Sri Amritsar Sahib, Punjab, India"),
     Song(
        title: "Takht Sri Hazur Sahib",  imageAssetPath:"assets/hazursahib.jpg", path: "https://radio.sikhnet.com/proxy/channel7/live", subtitle: "Hazur Sahib (HD)", location: "Sri Abchal Nagar, Nanded, India"),
    Song(
        title: "Gurdwara Sisganj Sahib",  imageAssetPath:"assets/SisganjSahib.jpg", path: "https://radio.sikhnet.com/proxy/gsisganjsahib/live", subtitle: "Gurdwara Sisganj Sahib (HD)", location: "Chandni Chowk, Delhi, India"),
    Song(
        title: "Gurdwara Dukh Niwaran Sahib",  imageAssetPath:"assets/dukhniwaransahib.jpg", path: "https://radio.sikhnet.com/proxy/channel10/live", subtitle: "Dukh Niwaran Sahib (HD)", location: "Ludhiana, Punjab, India"),
     ];

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Column(
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(232, 159, 46, 1.0), // Light Pink
                    Colors.white,      // White
                  ],
                ),
              ),
            ),

            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(232, 159, 46, 1.0), // Light Pink
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Live Kirtan HD Audio',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.black),
                      onPressed: () async{
                        // Text to share
                        String textToShare = 'Hello, Download this Amazing Live Kirtan HD Audio Player from Play Store.';  // You can replace this with dynamic text
                        await Share.share(textToShare);

    // Share the text
                        // Share.share(textToShare);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Image Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/darbarsahib.jpg', // Replace with the correct image path
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return SongTile(song: songs[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 0.5, // Adjust thickness as needed
                    height: 1, // Adjust height as needed
                  );
                },
              ),
            )



            // ListView Section
            // Expanded(  // Use Expanded to let the ListView take the remaining space
            //   child: ListView.builder(
            //     itemCount: kirtans.length,
            //     itemBuilder: (context, index) {
            //       final kirtan = kirtans[index];
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 8.0),
            //         child: AudioPlayerWidget(
            //           liveStreamUrl: kirtan['liveStreamUrl']!,
            //           title: kirtan['title']!,
            //           subtitle: kirtan['subtitle']!,
            //           location: kirtan['location']!,
            //           imageAssetPath: kirtan['imageAssetPath']!,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      );


  }
}