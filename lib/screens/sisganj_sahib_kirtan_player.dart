import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

class SisganjSahibKirtanPlayer extends StatefulWidget{
  @override
  State<SisganjSahibKirtanPlayer> createState() => _SisganjSahibKirtanPlayerState();
}

class _SisganjSahibKirtanPlayerState extends State<SisganjSahibKirtanPlayer> {

  final AudioPlayer _audioPlayer = AudioPlayer(); // Use just_audio's AudioPlayer
  bool isPlaying = false;
  final String liveKirtanUrl = 'https://radio.sikhnet.com/proxy/gsisganjsahib/live';
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingPath;

  void _showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // The duration for which the message is visible
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
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
                  'assets/SisganjSahib.jpg',
                  width: double.infinity,
                  height: 435,
                  fit: BoxFit.fill, // Adjust how the image is fitted
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // Adds space around each child
                    children: [

                      InkWell(
                        onTap: () async{

                          if(isRecording){
                            String? filePath = await  audioRecorder.stop();
                            if(filePath !=  null){
                              setState((){
                                isRecording=false;
                                recordingPath = filePath;
                                _showMessage(context, "Recording stopped and saved to ${recordingPath}");
                                print(recordingPath);
                                // await _audioPlayer.setFilePath(filePath);
                                // _audioPlayer.play();
                              });
                            }
                          }
                          else{
                            print("clicked1");
                            if(await audioRecorder.hasPermission()){
                              print("clicked111");

                              final  appDocumentsDir = await getExternalStorageDirectory();
                              final String filePath = "${appDocumentsDir!.path}/recording_${DateTime.now().millisecondsSinceEpoch}.mp3";

                              await audioRecorder.start(const RecordConfig(), path: filePath);

                              setState((){
                                isRecording = true;
                                recordingPath = null;
                              });
                            }
                          }
                        },
                        child: Icon(
                          Icons.radio_button_checked,
                          color: !isRecording?Colors.white:Colors.red,
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
    throw UnimplementedError();
  }
}