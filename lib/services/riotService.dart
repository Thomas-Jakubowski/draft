import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Champion.dart';

class RiotService {
  final String baseUrlJson = 'https://ddragon.leagueoflegends.com';
  final String baseUrlAPI = 'https://ddragon.leagueoflegends.com';

  Future<String> fetchLatestVersion() async {
    final response = await http.get(Uri.parse('$baseUrlJson/api/versions.json'));

    if (response.statusCode == 200) {
      List<dynamic> versions = jsonDecode(response.body);
      return versions.first;
    } else {
      throw Exception('Failed to fetch game versions');
    }
  }

  Future<List<Champion>> fetchChampions() async {
    try {
      String version = await fetchLatestVersion();
      final response = await http.get(Uri.parse('$baseUrlJson/cdn/$version/data/en_US/champion.json'));
      
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)['data'];
        List<Champion> champions = [];

        data.forEach((key, value) {
          champions.add(Champion(
            name: value['name'],
            type: value['tags']?.join(', ') ?? '',
            imageUrl: '$baseUrlJson/cdn/$version/img/champion/${value['image']['full']}',
            isFavorite: false,
            isFreeThisWeek: false,
            info: [value['info']['attack'], value['info']['defense'], value['info']['magic'], value['info']['difficulty']],
          ));
        });

        return champions;
      } else {
        throw Exception('Failed to fetch champions');
      }
    } catch (e) {
      throw Exception('Error fetching champions: $e');
    }
  }

  Future<List<Champion>> fetchFreeChampions() async {
    try {
      String version = await fetchLatestVersion();
      final response = await http.get(Uri.parse('$baseUrlAPI/lol/platform/v3/champion-rotations'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)['data'];
        List<Champion> freeChampions = [];

        data.forEach((key, value) {
          if (true) {
            freeChampions.add(Champion(
              name: value['name'],
              type: value['tags']?.join(', ') ?? '',
              imageUrl: '$baseUrlJson/cdn/$version/img/champion/${value['image']['full']}',
              isFreeThisWeek: true,
              info: [value['info']['attack'], value['info']['defense'], value['info']['magic'], value['info']['difficulty']]
            ));
          }
        });
        return freeChampions;
      } else {
        throw Exception('Failed to fetch free champions');
      }
    } catch (e) {
      throw Exception('Error fetching free champions: $e');
    }
  }

  setFreeChampions(List<Champion> champions, List<Champion> freeChampions){
    // champions.map(champions() => {

    // })
  }
}
