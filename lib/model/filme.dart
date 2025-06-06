class Filme {
  final int id;
  final String imageUrl;
  final String titulo;
  final String genero;
  final String faixaEtaria;
  final String duracao;
  final double pontuacao;
  final String descricao;
  final int ano;

  Filme({
    required this.id,
    required this.imageUrl,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
  });

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'] as int,
      imageUrl: map['imageUrl'] as String,
      titulo: map['titulo'] as String,
      genero: map['genero'] as String,
      faixaEtaria: map['faixaEtaria'] as String,
      duracao: map['duracao'] as String,
      pontuacao:
          map['pontuacao'] is int
              ? (map['pontuacao'] as int).toDouble()
              : map['pontuacao'] as double,
      descricao: map['descricao'] as String,
      ano: map['ano'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
    };
  }
}
