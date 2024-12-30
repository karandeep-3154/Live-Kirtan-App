import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String liveStreamUrl;
  final String title;
  final String subtitle;
  final String location;
  final String imageAssetPath;
  final bool isRecorded;

  const AudioPlayerWidget({
    Key? key,
    required this.liveStreamUrl,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.imageAssetPath,
    required this.isRecorded,
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

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

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

  Future<void> download() async {
    try {

      _showMessage(context, "Download Started");
      final response = await http.get(Uri.parse(widget.liveStreamUrl));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final filePath =
            "${directory!.path}/downloaded_audio_${widget.subtitle}";
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        _showMessage(context, "Downloaded successfully to $filePath");
      } else {
        _showMessage(context, "Failed to download audio.");
      }
    } catch (e) {
      print("Download error: $e");
      _showMessage(context, "An error occurred during download.");
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer.positionStream.listen((position) {
      setState(() => _currentPosition = position);
    });
    _audioPlayer.durationStream.listen((duration) {
      setState(() => _totalDuration = duration ?? Duration.zero);
    });
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: const Color.fromRGBO(232, 159, 46, 1.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  widget.imageAssetPath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            widget.isRecorded
                ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Slider(
                value: _currentPosition.inSeconds.toDouble(),
                max: _totalDuration.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await _audioPlayer.seek(position);
                  setState(() => _currentPosition = position);
                },
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
              ),
            )
                : const SizedBox(),
            widget.isRecorded
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(_currentPosition),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    _formatDuration(_totalDuration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: widget.isRecorded ? download : () {
                      _toggleRecording();
                    },
                    child: Icon(
                      widget.isRecorded
                          ? Icons.download_for_offline
                          : Icons.radio_button_checked,
                      color: (isRecording)?Colors.red:Colors.white,
                      size: 70.0,
                    ),
                  ),
                  InkWell(
                    onTap: _togglePlayPause,
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _audioPlayer.stop();
                      setState(() => isPlaying = false);
                      Navigator.pop(context);
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
                Text(widget.title,
                    style: const TextStyle(
                        color: Color.fromRGBO(12, 96, 96, 1),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                Text(widget.location,
                    style: const TextStyle(
                        color: Color.fromRGBO(12, 96, 96, 1),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
