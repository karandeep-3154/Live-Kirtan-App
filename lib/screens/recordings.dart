import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';
import 'package:path_provider/path_provider.dart';
// import 'audio_player_widget.dart'; // Import the AudioPlayerWidget if it's in a different file

class Recordings extends StatefulWidget {
  @override
  State<Recordings> createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  List<File> recordings = [];

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  // Function to load recordings from storage
  Future<void> _loadRecordings() async {
    final directory = await getExternalStorageDirectory();
    final recordingDir = Directory(directory!.path);
    if (recordingDir.existsSync()) {
      final files = recordingDir
          .listSync()
          .where((item) => item is File && item.path.endsWith('.mp3'))
          .cast<File>()
          .toList();
      setState(() {
        recordings = files;
      });
    }
  }

  // Function to delete the recording
  void _deleteRecording(File file) {
    file.deleteSync();
    _loadRecordings();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 159, 46, 1.0),
        title: const Text("My Recordings", style: TextStyle(color: Colors.white)),
      ),
      body: recordings.isEmpty
          ? const Center(
        child: Text(
          "No recordings found.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: recordings.length,
        itemBuilder: (context, index) {
          final file = recordings[index];
          final fileName = file.path.split('/').last;

          // Create a mock data for title, subtitle, and image
          final title = fileName;
          final subtitle = "Subtitle for $fileName";
          final location = "Location info for $fileName";
          final imageAssetPath = "assets/placeholder_image.jpg"; // Replace with actual image path

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.audiotrack, color: Colors.orange),
              title: Text(
                fileName,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: const Text('Tap to view details'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteRecording(file),
              ),
              onTap: () {
                // Navigate to the AudioPlayerWidget screen on tap without playing immediately
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioPlayerWidget(
                      liveStreamUrl: file.path,
                      title: "Recorded Kirtan Audio ",
                      subtitle: "Recorded Kirtan Audio ",
                      location: "India",
                      imageAssetPath: "assets/hukamnamma.jpg",
                      isRecorded: true,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
