import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String liveStreamUrl;
  final String title;
  final String subtitle;
  final String location;
  final String imageAssetPath;

  const AudioPlayerWidget({
    Key? key,
    required this.liveStreamUrl,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.imageAssetPath,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool isPlaying = false;
  bool isRecording = false;
  String? recordingPath;

  void _showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      setState(() => isPlaying = false);
      await _audioPlayer.pause();
    } else {
      try {
        setState(() => isPlaying = true);
        await _audioPlayer.setUrl(widget.liveStreamUrl);
        await _audioPlayer.play();
      } catch (e) {
        print("Error loading stream: $e");
        _showMessage(context, "Failed to play audio stream.");
      }
    }
  }

  Future<void> _toggleRecording() async {
    if (isRecording) {
      String? filePath = await _audioRecorder.stop();
      if (filePath != null) {
        setState(() {
          isRecording = false;
          recordingPath = filePath;
        });
        _showMessage(context, "Recording saved to $filePath");
      }
    } else {
      if (await _audioRecorder.hasPermission()) {
        final appDocumentsDir = await getExternalStorageDirectory();
        final filePath = "${appDocumentsDir!.path}/recording_${DateTime.now().millisecondsSinceEpoch}.mp3";

        await _audioRecorder.start(const RecordConfig(), path: filePath);
        setState(() => isRecording = true);
      } else {
        _showMessage(context, "Recording permission not granted.");
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 159, 46, 1.0),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: const Color.fromRGBO(232, 159, 46, 1.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20), // Adjust padding as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                child: Image.asset(
                  widget.imageAssetPath,
                  width: double.infinity,
                  height: 435,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.imageAssetPath!= "assets/hukamnamma.jpg"
                      ? InkWell(
                    onTap: _toggleRecording,
                    child: Icon(
                      Icons.radio_button_checked,
                      color: isRecording ? Colors.red : Colors.white,
                      size: 70.0,
                    ),
                  )
                      : Container(),
                  InkWell(
                    onTap: _togglePlayPause,
                    child: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _audioPlayer.stop();
                      setState(() => isPlaying = false);
                      Navigator.pop(context); // Navigate back to the previous screen
                    },
                    child: const Icon(
                      Icons.stop_circle,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(widget.subtitle, style: const TextStyle(color: Color.fromRGBO(12, 96, 96, 1), fontSize: 19, fontWeight: FontWeight.bold)),
                Text(widget.location, style: const TextStyle(color: Color.fromRGBO( 12, 96, 96, 1), fontSize: 19, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}