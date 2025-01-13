// fetch_data.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplaySelectedChampions extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class DisplayAllChampions extends StatefulWidget {
  const DisplayAllChampions({super.key});

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<DisplayAllChampions> {
  List<String> _championNames = [];
  List<String> _imageUrl = [];
  List<List<String>> championSelectedBlueSide = [];
  List<List<String>> championSelectedRedSide = [];
  int turnIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final responseVersion = await http.get(
        Uri.parse('https://ddragon.leagueoflegends.com/api/versions.json'));
    String version = jsonDecode(responseVersion.body)[0];
    final responseLegends = await http.get(Uri.parse(
        'https://ddragon.leagueoflegends.com/cdn/${version}/data/en_US/champion.json'));

    if (responseLegends.statusCode == 200) {
      var data = jsonDecode(responseLegends.body);
      var championsData = data['data'];

      List<String> championNames = [];
      List<String> imageUrl = [];

      championsData.forEach((key, value) {
        championNames.add(value['name']);
        imageUrl.add(
            'https://ddragon.leagueoflegends.com/cdn/${version}/img/champion/${value['image']['full']}');
      });

      setState(() {
        _championNames = championNames;
        _imageUrl = imageUrl;
      });
    }
  }

  void _setChampionSelected(String name, String imageUrl) {
    setState(() {
      if (turnIndex == 1 ||
          turnIndex == 4 ||
          turnIndex == 5 ||
          turnIndex == 8 ||
          turnIndex == 9) {
        championSelectedBlueSide.add([imageUrl, name]);
        _imageUrl.remove(imageUrl);
        _championNames.remove(name);
        turnIndex += 1;
      } else if (turnIndex == 2 ||
          turnIndex == 3 ||
          turnIndex == 6 ||
          turnIndex == 7 ||
          turnIndex == 10) {
        championSelectedRedSide.add([imageUrl, name]);
        _imageUrl.remove(imageUrl);
        _championNames.remove(name);
        turnIndex += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Row(
          children: championSelectedBlueSide.map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Image.network(
                    item[0],
                    fit: BoxFit.cover,
                    width: screenSize.width / 6,
                    height: screenSize.width / 6,
                  ),
                  Text(
                    item[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: _imageUrl.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _setChampionSelected(_championNames[index], _imageUrl[index]);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Image.network(
                          _imageUrl[index],
                          fit: BoxFit.cover,
                          width: screenSize.width/7,
                          height: screenSize.width/7,
                        );
                      },
                    ),
                    Text(
                      _championNames[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          children: championSelectedRedSide.map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Image.network(
                    item[0],
                    fit: BoxFit.cover,
                    width: screenSize.width / 6,
                    height: screenSize.width / 6,
                  ),
                  Text(
                    item[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
