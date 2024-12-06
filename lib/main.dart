import 'package:draft/my_widgets/search_barre.dart';
import 'package:draft/my_widgets/timerDraft.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            Container(
              height: 690,
              width: 350,
              color: const Color.fromARGB(255, 247, 233, 239),
              child: const Column(
                children: [
                  Row(
                    children: [timerDraft(), Text("data")],
                  ),
                  SearchBarre(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
