import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';

class RagiListOfShabadsScreen extends StatefulWidget {
  final String url;
  final String name;
  final String stub;

  const RagiListOfShabadsScreen({required this.url, required this.name, required this.stub});

  @override
  _RagiListOfShabadsScreenState createState() => _RagiListOfShabadsScreenState();
}

class _RagiListOfShabadsScreenState extends State<RagiListOfShabadsScreen> {
  List<Map<String, String>> titleAndUrl = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(widget.url));

      if (response.statusCode == 200) {
        // Parse the HTML content
        final document = htmlParser.parse(response.body);

        // Extract the list items
        final items = document.querySelectorAll('#directory-listing li');

        // Extract data-name and data-href
        List<Map<String, String>> extractedData = items
            .where((item) =>
        item.attributes.containsKey('data-name') &&
            item.attributes.containsKey('data-href'))
            .map((item) => {
          'title': item.attributes['data-name'] ?? '',
          'url': item.attributes['data-href'] ?? '',
        })
            .toList();

        // Update state
        setState(() {
          titleAndUrl = extractedData;
        });
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ragi List of Shabads")),
      body: titleAndUrl.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemCount: titleAndUrl.length,
        itemBuilder: (context, index) {
          final item = titleAndUrl[index];
          return ListTile(
            title: Text(item['title'] ?? ''),

            onTap: () {
              final url = "https://sgpc.net/ragi-wise/${item['url']}";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(liveStreamUrl: url, title: widget.name, subtitle: widget.name, location: "India", imageAssetPath: "assets/hukamnamma.jpg"),
                ),
              );
            },
          );
        },

        separatorBuilder:(context, index){
          return Divider(height: 10, thickness: 1,);
        },
      ),
    );
  }
}