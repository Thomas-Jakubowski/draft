// main.dart
import 'package:flutter/material.dart';
import 'displayChampions.dart'; // Importer le fichier DisplayChampions

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
        body: const DisplayAllChampions()
      ),
    );
  }
}
