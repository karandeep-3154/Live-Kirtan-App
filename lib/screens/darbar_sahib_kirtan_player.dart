
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DarbarSahibKirtanPlayer extends StatefulWidget{
  const DarbarSahibKirtanPlayer({super.key});

  @override
  State<DarbarSahibKirtanPlayer> createState() => _DarbarSahibKirtanPlayerState();
}

class _DarbarSahibKirtanPlayerState extends State<DarbarSahibKirtanPlayer> {

  final AudioPlayer _audioPlayer = AudioPlayer(); // Use just_audio's AudioPlayer
  bool isPlaying = false;
  final String liveKirtanUrl = 'https://live.sgpc.net:8444/;'; // Replace with your live URL

  Future<void> _togglePlayPause() async {

    if (isPlaying) {
      isPlaying = !isPlaying;
      setState(() {
      });
      await _audioPlayer.pause();

    } else {
      try {
        isPlaying = !isPlaying;
        setState(() {
        });
        await _audioPlayer.setUrl(liveKirtanUrl);  // Set the URL for the live audio stream
        await _audioPlayer.play();  // Start playing

      } catch (e) {
        print("Error loading stream: $e");
      }
    }


  }

  @override
  void dispose() {
    _audioPlayer.dispose();  // Dispose of the player when done
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(6, 53, 84, 1.0),
        title: Text("Darbar Sahib HD Live Kirtan", style: TextStyle(color: Color.fromRGBO(245, 245, 245, 1.0))

      )),
      body: Container(
color: Color.fromRGBO(6, 53, 84, 1.0),
        child: Column(
          children: [
            Image.asset(
              'assets/darbarsahib.jpg',
              width: double.infinity,
              height: 435,
              fit: BoxFit.cover, // Adjust how the image is fitted
            ),

           Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Adds space around each child
                children: [

                  InkWell(
                    onTap: () {
                      print("Icon clicked!");
                      // Call your function here
                    },
                    child: Icon(
                      Icons.radio_button_checked,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _togglePlayPause();
                      // Call your function here
                    },
                    child: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _togglePlayPause();
                      // Call your function here
                    },
                    child: Icon(
                      Icons.stop_circle,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  )

                ],
              ),
            ),
            Column(
              children: [
                Text("Live Stream", style: TextStyle(color: Color.fromRGBO(123, 141, 93, 1.0), fontSize: 19, ), )
       ,         Text("Harminder Sahib (HD)", style: TextStyle(color: Colors.white, fontSize: 19, ), )
      ,Text("Sri Amritsar Sahib, Punjab, India", style: TextStyle(color: Color.fromRGBO(123, 141, 93, 1.0), fontSize: 19, fontWeight: FontWeight.bold ), )
              ],
            )
          ],
        )
      ));

  }
}