import 'package:flutter/material.dart';
import '../services/riotService.dart';
import 'models/Champion.dart';
import 'models/Player.dart';

class DisplayAllChampions extends StatefulWidget {
  const DisplayAllChampions({super.key});

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<DisplayAllChampions> {
  List<Champion> _champions = [];
  List<Player> players = [];
  int turnIndex = 1;

  final RiotService _riotService = RiotService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Champion> champions = await _riotService.fetchChampions();
      
      setState(() {
        _champions = champions;
      });
    } catch (e) {
      print("Erreur lors du chargement des champions: $e");
    }
  }

  void _setChampionSelected(Champion championSelected) {
    setState(() {
      if (turnIndex == 1 ||
          turnIndex == 4 ||
          turnIndex == 5 ||
          turnIndex == 8 ||
          turnIndex == 9) {
        players.add(Player(name: "", championPick: championSelected, isBlueSide: true));
        turnIndex += 1;
        _champions.remove(championSelected);
      } else if (turnIndex == 2 ||
          turnIndex == 3 ||
          turnIndex == 6 ||
          turnIndex == 7 ||
          turnIndex == 10) {
        players.add(Player(name: "", championPick: championSelected, isBlueSide: false));
        turnIndex += 1;
        _champions.remove(championSelected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Player> blueSidePlayers = players.where((player) => player.isBlueSide).toList();
    List<Player> redSidePlayers = players.where((player) => !player.isBlueSide).toList();
    final Size screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Row(
          children: blueSidePlayers.map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Image.network(
                    item.championPick.imageUrl,
                    fit: BoxFit.cover,
                    width: screenSize.width / 6,
                    height: screenSize.width / 6,
                  ),
                  Text(
                    item.name,
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
            itemCount: _champions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _setChampionSelected(_champions[index]);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Image.network(
                          _champions[index].imageUrl,
                          fit: BoxFit.cover,
                          width: screenSize.width / 7,
                          height: screenSize.width / 7,
                        );
                      },
                    ),
                    Text(
                      _champions[index].name,
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
          children: redSidePlayers.map<Widget>((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Image.network(
                    item.championPick.imageUrl,
                    fit: BoxFit.cover,
                    width: screenSize.width / 6,
                    height: screenSize.width / 6,
                  ),
                  Text(
                    item.name,
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
