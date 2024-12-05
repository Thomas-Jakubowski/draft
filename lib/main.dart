import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('API Fetch Example')),
        body: const FetchData(),
      ),
    );
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
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

      List<String> championIds = [];
      List<String> championNames = [];
      List<String> imageUrl = [];

      championsData.forEach((key, value) {
        championIds.add(value['id']);
        championNames.add(value['name']);
        imageUrl.add('https://ddragon.leagueoflegends.com/cdn/${version}/img/champion/${value['image']['full']}');
      });

      setState(() {
        _championNames = championNames;
        _imageUrl = imageUrl;
      });

      print(championIds);
    }
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
        return Card(
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
        );
      },
    );
  }
}
