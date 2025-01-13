class Champion {
  String name;
  String type;
  String imageUrl;
  bool isFavorite;
  bool isFreeThisWeek;
  List<int> info;

  Champion({
    this.name = "",
    this.type = "",
    this.imageUrl = "",
    this.isFavorite = false,
    this.isFreeThisWeek = false,
    this.info = const [],
  });

  void setFavorite() {
    isFavorite = !isFavorite;
  }
}

