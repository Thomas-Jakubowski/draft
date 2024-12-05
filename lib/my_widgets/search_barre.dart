import 'package:flutter/material.dart';

class SearchBarre extends StatefulWidget {
  const SearchBarre({super.key});

  @override
  State<SearchBarre> createState() => _SearchBarreState();
}

class _SearchBarreState extends State<SearchBarre> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black.withOpacity(1), // Opacité de l'icône de loupe
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 212, 73, 3),
        border: const OutlineInputBorder(
          //borderRadius: BorderRadius.circular(30),
          //borderSide: BorderSide.none,
          borderSide: BorderSide(
            color: Colors.black,
            width: 5.0,
          ),
        ),
      ),
      style: const TextStyle(
          color: Colors.black), // Couleur du texte lorsque l'utilisateur tape
    );
  }
}
