import 'dart:async';
import 'package:flutter/material.dart';

class timerDraft extends StatefulWidget {
  const timerDraft({super.key});

  @override
  State<timerDraft> createState() => _timerDraftState();
}

class _timerDraftState extends State<timerDraft> {
  int defaultValueCounter = 30;
  int _counter = 0;
  late Timer _timer;
  Color colorBackground = Colors.blue;
  List<Color> colorTest = [Colors.black, Colors.blue];

  @override
  void initState() {
    _counter = defaultValueCounter;
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_counter > 0) _counter--;
        if (_counter > 20) {
          colorBackground = const Color.fromARGB(255, 21, 236, 64);
        } else if (_counter > 10)
          // ignore: curly_braces_in_flow_control_structures
          colorBackground = const Color.fromARGB(255, 216, 247, 14);
        else if (_counter > 5)
          // ignore: curly_braces_in_flow_control_structures
          colorBackground = const Color.fromARGB(255, 237, 144, 13);
        else
          // ignore: curly_braces_in_flow_control_structures
          colorBackground = const Color.fromARGB(255, 237, 14, 14);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: colorBackground,
          shape: BoxShape.circle, // Définit la forme comme un cercle
          //borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_counter', // Affichage du compteur
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
