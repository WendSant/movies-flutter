import 'package:flutter/material.dart';
import 'screens/filmes_home.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Inicialize o databaseFactory apenas para desktop (Linux, Windows, macOS)
  if (!Platform.isAndroid && !Platform.isIOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      debugShowCheckedModeBanner: false, // Adicione esta linha
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FilmesHomePage(), // Página de filmes como tela inicial
    );
  }
}
