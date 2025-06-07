import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../databasehelper.dart';
import '../model/filme.dart';

class AdicionarFilmePage extends StatefulWidget {
  final Filme? filme;
  const AdicionarFilmePage({super.key, this.filme});

  @override
  State<AdicionarFilmePage> createState() => _AdicionarFilmePageState();
}

class _AdicionarFilmePageState extends State<AdicionarFilmePage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _generoController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _anoController = TextEditingController();

  String _faixaEtaria = 'Livre';
  double _pontuacao = 3.0;

  final List<String> _faixas = ['Livre', '10', '12', '14', '16', '18'];

  @override
  void dispose() {
    _tituloController.dispose();
    _imageUrlController.dispose();
    _generoController.dispose();
    _duracaoController.dispose();
    _descricaoController.dispose();
    _anoController.dispose();
    super.dispose();
  }

  Future<void> _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      final filmeEditado = Filme(
        id: widget.filme?.id ?? 0,
        imageUrl: _imageUrlController.text,
        titulo: _tituloController.text,
        genero: _generoController.text,
        faixaEtaria: _faixaEtaria,
        duracao: _duracaoController.text,
        pontuacao: _pontuacao,
        descricao: _descricaoController.text,
        ano: int.tryParse(_anoController.text) ?? 2024,
      );
      if (widget.filme == null) {
        await DatabaseHelper().insertFilme(filmeEditado);
      } else {
        await DatabaseHelper().updateFilme(filmeEditado);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _tituloController.text = widget.filme!.titulo;
      _imageUrlController.text = widget.filme!.imageUrl;
      _generoController.text = widget.filme!.genero;
      _duracaoController.text = widget.filme!.duracao;
      _descricaoController.text = widget.filme!.descricao;
      _anoController.text = widget.filme!.ano.toString();
      _faixaEtaria = widget.filme!.faixaEtaria;
      _pontuacao = widget.filme!.pontuacao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Filme')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o título' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextFormField(
                controller: _generoController,
                decoration: InputDecoration(labelText: 'Gênero'),
              ),
              DropdownButtonFormField<String>(
                value: _faixaEtaria,
                decoration: InputDecoration(labelText: 'Faixa Etária'),
                items: _faixas.map((faixa) {
                  return DropdownMenuItem(value: faixa, child: Text(faixa));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _faixaEtaria = value!;
                  });
                },
              ),
              TextFormField(
                controller: _duracaoController,
                decoration: InputDecoration(labelText: 'Duração'),
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text('Pontuação'),
              SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: _pontuacao,
                size: 32.0,
                onRatingChanged: (value) {
                  setState(() {
                    _pontuacao = value;
                  });
                },
                color: Colors.amber,
                borderColor: Colors.amber,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 4,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _salvarFilme,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.save, color: Colors.white),
        tooltip: 'Salvar',
        shape: const CircleBorder(),
      ),
    );
  }
}
