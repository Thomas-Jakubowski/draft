import 'Champion.dart';

class Player {
  String name;
  Champion championPick;
  bool isBlueSide;

  Player({
    this.name = "",
    required this.championPick,
    required this.isBlueSide,
  });
}

