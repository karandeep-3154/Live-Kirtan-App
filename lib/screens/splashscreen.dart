import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';
import 'package:livekirtanapp/screens/mainscreen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>(MainScreen())));
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image widget
              Image.asset(
                'assets/darbarsahib.jpg', // Replace with your image file
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),

              // Main text in Gurmukhi
              const Text(
                'ਗੁਰਬਾਣੀ ਕੀਰਤਨ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle in English
              const Text(
                'The Sacred Hymns',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

    );
  }
}