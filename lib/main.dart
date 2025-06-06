import 'package:flutter/material.dart';
import 'screens/filmes_home.dart';

void main() => runApp(FilmesApp());

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FilmesHomePage(), // Página de filmes como tela inicial
    );
  }
}
