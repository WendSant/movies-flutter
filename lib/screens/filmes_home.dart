import 'package:flutter/material.dart';
import '../databasehelper.dart';
import '../model/filme.dart';

class FilmesHomePage extends StatefulWidget {
  const FilmesHomePage({super.key});

  @override
  _FilmesHomePageState createState() => _FilmesHomePageState();
}

class _FilmesHomePageState extends State<FilmesHomePage> {
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final lista = await DatabaseHelper().getFilmes();
    setState(() {
      filmes = lista;
    });
  }

  Future<void> _adicionarFilme() async {
    final novoFilme = Filme(
      id: 0,
      imageUrl: 'https://example.com/novo.jpg',
      titulo: 'Novo Filme',
      genero: 'Gênero',
      faixaEtaria: 'Livre',
      duracao: '1h 30min',
      pontuacao: 3.5,
      descricao: 'Descrição do novo filme.',
      ano: 2025,
    );
    await DatabaseHelper().insertFilme(novoFilme);
    _carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filmes')),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                filme.imageUrl,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(filme.titulo),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(filme.genero),
                  Text(filme.duracao),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < filme.pontuacao.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarFilme,
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
