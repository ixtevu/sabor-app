import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sabor_app/models/receita.dart';
import 'package:sabor_app/models/receitas_mock.dart';

abstract class ReceitaRepository {
  Future<List<Receita>> buscar(String termo);
}

class ReceitaRepositoryHttp implements ReceitaRepository {
  final http.Client client;

  ReceitaRepositoryHttp(this.client);

  @override
  Future<List<Receita>> buscar(String termo) async {
    final url = Uri.https(
      "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken",
    );
    final resposta = await client.get(url);
    if (resposta.statusCode != 200) {
      throw Exception('Erro ${resposta.statusCode} ao buscar receitas');
    }
    final mapa = jsonDecode(resposta.body) as Map<String, dynamic>;
    final meals = mapa['meals'] as List<dynamic>;
    return meals?.map((m) => Receita.fromJson(m as Map<String, dynamic>))
            .toList() ??
        [];
  }
}

class ReceitaRepositoryMock implements ReceitaRepository {
  @override
  Future<List<Receita>> buscar(String termo) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return filtrarPorNome(receitasMock, termo);
  }
}
