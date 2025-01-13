import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seconde Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Retourner à la page précédente
            Navigator.pop(context);
          },
          child: Text('Retour à la première page UwUUUUUUUUUUUUU'),
        ),
      ),
    );
  }
}
