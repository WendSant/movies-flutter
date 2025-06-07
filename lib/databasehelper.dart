import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model/filme.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'filmes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageUrl TEXT,
            titulo TEXT,
            genero TEXT,
            faixaEtaria TEXT,
            duracao TEXT,
            pontuacao REAL,
            descricao TEXT,
            ano INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertFilme(Filme filme) async {
    final dbClient = await db;
    return await dbClient.insert('filmes', filme.toMap()..remove('id'));
  }

  Future<List<Filme>> getFilmes() async {
    final dbClient = await db;
    final maps = await dbClient.query('filmes');
    return maps.map((map) => Filme.fromMap(map)).toList();
  }

  Future<int> updateFilme(Filme filme) async {
    final dbClient = await db;
    return await dbClient.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }
}
