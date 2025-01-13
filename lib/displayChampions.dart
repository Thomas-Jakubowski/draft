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
  int? _hoveredIndex;

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

  void _showChampionDetails(Champion champion, List<Champion> champions) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                champion.imageUrl,
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10), // Espacement entre l'image et le texte
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Champion: ${champion.info.length > 1 ? champion.name : "N/A"}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Attack: ${champion.info.isNotEmpty ? champion.info[0] : "N/A"}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Defense: ${champion.info.length > 1 ? champion.info[1] : "N/A"}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Magic: ${champion.info.length > 1 ? champion.info[1] : "N/A"}',
                      style: const TextStyle(fontSize: 14)),
                  Text('Difficulty: ${champion.info.length > 1 ? champion.info[1] : "N/A"}',
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Fermer',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    champion.setFavorite();
                    champions.sort((a, b) => b.isFavorite ? 1 : 0);
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  champion.isFavorite ? 'Retirer des favoris' : 'Ajouter au favoris',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    _champions.sort((a, b) => b.isFavorite ? 1 : 0);

    List<Player> blueSidePlayers = players.where((player) => player.isBlueSide).toList();
    List<Player> redSidePlayers = players.where((player) => !player.isBlueSide).toList();
    final Size screenSize = MediaQuery.sizeOf(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...blueSidePlayers.map<Widget>((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.network(
                        item.championPick.imageUrl,
                        fit: BoxFit.cover,
                        width: screenSize.width / 7,
                        height: screenSize.width / 7,
                      ),
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
            Expanded(child: Container()),
          ],
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
                onLongPress: () {
                  _showChampionDetails(_champions[index], _champions);
                },
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _hoveredIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _hoveredIndex = null;
                    });
                  },
                  child: AnimatedScale(
                    scale: _hoveredIndex == index ? 1.2 : 1.0,
                    duration: Duration(milliseconds: 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Image.network(
                                _champions[index].imageUrl,
                                fit: BoxFit.cover,
                                width: screenSize.width / 8,
                                height: screenSize.width / 8,
                              );
                            },
                          ),
                        ),
                        Text(
                          _champions[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...redSidePlayers.map<Widget>((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.network(
                        item.championPick.imageUrl,
                        fit: BoxFit.cover,
                        width: screenSize.width / 7,
                        height: screenSize.width / 7,
                      ),
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
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }
}
