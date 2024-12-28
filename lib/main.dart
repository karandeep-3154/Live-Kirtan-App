import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livekirtanapp/screens/kirtan_tiles.dart'; // Import just_audio

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
        textTheme: GoogleFonts.poppinsTextTheme(),
      
        useMaterial3: true,
      ),
      home:  KirtanListScreen()
    );
  }
}
