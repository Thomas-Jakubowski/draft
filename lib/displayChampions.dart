// fetch_data.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayChampions extends StatefulWidget {
  const DisplayChampions({super.key});

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<DisplayChampions> {
  List<String> _championNames = [];
  List<String> _imageUrl = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final responseVersion = await http.get(Uri.parse('https://ddragon.leagueoflegends.com/api/versions.json'));
    String version = jsonDecode(responseVersion.body)[0];
    final responseLegends = await http.get(Uri.parse('https://ddragon.leagueoflegends.com/cdn/${version}/data/en_US/champion.json'));

    if (responseLegends.statusCode == 200) {
      var data = jsonDecode(responseLegends.body);
      var championsData = data['data'];

      List<String> championNames = [];
      List<String> imageUrl = [];

      championsData.forEach((key, value) {
        championNames.add(value['name']);
        imageUrl.add('https://ddragon.leagueoflegends.com/cdn/${version}/img/champion/${value['image']['full']}');
      });

      setState(() {
        _championNames = championNames;
        _imageUrl = imageUrl;
      });
    }
  }

  void _showChampionDetails(String name, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              SizedBox(height: 10),
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _imageUrl.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _showChampionDetails(_championNames[index], _imageUrl[index]);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  _imageUrl[index],
                  fit: BoxFit.cover,
                ),
                Text(
                  _championNames[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
