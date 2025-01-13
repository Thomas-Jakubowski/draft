import 'package:draft/secondPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
        ),
      ),
    );
  }
}
/*
import 'package:draft/my_widgets/search_barre.dart';
import 'package:draft/my_widgets/timerDraft.dart';
import 'package:draft/secondPage.dart';
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
              child: Column(
                children: [
                  const Row(
                    children: [timerDraft(), Text("data")],
                  ),
                  Container(
                    //////////////////////////////////////////////////////////////////////////////////
                    child: ElevatedButton(
                      child: const Text('Open ThE route'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage()),
                        );
                      },
                    ),

                    ///////////////////////////////////////////////////////////////////////////////////
                  ),
                  const SearchBarre(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
*/
