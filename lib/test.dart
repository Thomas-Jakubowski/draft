import 'dart:async';
import 'package:flutter/material.dart';

// Widget Timer personnalisé
class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _counter = 0; // Variable pour le compteur
  late Timer _timer; // Déclaration du timer

  // Méthode pour démarrer le timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _counter++; // Incrémenter le compteur chaque seconde
      });
    });
  }

  // Annuler le timer lorsque le widget est supprimé pour éviter les fuites de mémoire
  @override
  void initState() {
    super.initState();
    _startTimer(); // Démarrer le timer lorsque le widget est créé
  }

  @override
  void dispose() {
    _timer.cancel(); // Annuler le timer lorsque le widget est détruit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Timer Widget',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Compteur: $_counter', // Affichage du compteur
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer Widget Example'),
        ),
        body: TimerWidget(), // Utilisation du widget TimerWidget
      ),
    );
  }
}
