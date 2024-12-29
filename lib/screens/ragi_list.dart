import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livekirtanapp/screens/ragi_list_of_shabads.dart';


class RagiListScreen extends StatefulWidget {

  @override
  State<RagiListScreen> createState() => _RagiListScreenState();
}

class _RagiListScreenState extends State<RagiListScreen> {
  List<dynamic> ragiList = [];
  Future<void> loadRagiList() async {
    final String jsonString = await rootBundle.loadString('assets/ragis_list.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      ragiList = jsonData;
    });
  }
  @override
  void initState() {
    super.initState();
    loadRagiList();
  }

  // final List<Map<String, String>> ragiList = [
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 159, 46, 1.0),
        title: const Text("Recorded Shabads", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: ragiList.length,
          itemBuilder: (context, index) {
            final ragi = ragiList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.audiotrack, color: Colors.orange),
                title: Text(
                  ragi['name']!,
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new, color: Colors.black),
                  onPressed: () {
                    final url = "https://sgpc.net/ragi-wise/index.php${ragi['href']}";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RagiListOfShabadsScreen(name:ragi['name']!, url: url, stub: ragi['href'].substring(5)),
                      ),
                    );
                  }, // Optional functionality for trailing button
                ),
                onTap: () {
                  final url = "https://sgpc.net/ragi-wise/index.php${ragi['href']}";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RagiListOfShabadsScreen(name:ragi['name']!, url: url,  stub: ragi['href'].substring(5)),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
