enum Dificuldade { facil, media, dificil }

extension DificuldadeTexto on Dificuldade {
  String get rotulo => switch (this) {
    Dificuldade.facil => 'Fácil',
    Dificuldade.media => 'Média',
    Dificuldade.dificil => 'Difícil',
  };
}

class Receita {
  final String id;
  final String nome;
  final String categoria;
  final String origem;
  final String imagemUrl;
  final int tempoMinutos;
  final Dificuldade dificuldade;
  final List<String> ingredientes;
  final String modoPreparo;
  final int porcoes;
  final bool vegetariana;

  const Receita({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.origem,
    this.imagemUrl = '',
    required this.tempoMinutos,
    required this.dificuldade,
    required this.ingredientes,
    required this.modoPreparo,
    this.porcoes = 4,
    this.vegetariana = false,
  });

  String get tempoFormatado => tempoMinutos >= 60
      ? '${tempoMinutos ~/ 60}h ${tempoMinutos % 60}min'
      : '${tempoMinutos} min';

  factory Receita.fromJson(Map<String, dynamic> json) {
    final ingredientes = <String>[];
    for (var i = 1; i <= 20; i++) {
      final item = (json['strIngredient$i'] as String?)?.trim() ?? "";
      final medida = (json['strMeasure$i'] as String?)?.trim() ?? "";
      if (item.isNotEmpty) {
        ingredientes.add(medida.isEmpty ? item : "$medida $item");
      }
    }
    final qtd = ingredientes.length;
    return Receita(
      id: json['idMeal&#39'] as String,
      nome: json['strMeal'] as String,
      categoria: json['strCategory'] as String? ?? 'Outros',
      origem: json['strArea'] as String? ?? '—',

      imagemUrl: json['strMealThumb'] as String? ?? '',
      modoPreparo: json['strInstructions'] as String? ?? '',
      ingredientes: ingredientes,
      tempoMinutos: 15 + qtd * 5,
      dificuldade: qtd <= 6
          ? Dificuldade.facil
          : (qtd <= 10 ? Dificuldade.media : Dificuldade.dificil),
    );
  }
  // Gera o mesmo formato da API: assim o fromJson serve para ler o que salvarmos
  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': nome,
    'strCategory': categoria,
    'strArea': origem,
    'strMealThumb': imagemUrl,
    'strInstructions': modoPreparo,

    for (var i = 0; i < ingredientes.length; i++)
      'strIngredient${i + 1}': ingredientes[i],
  };
}
