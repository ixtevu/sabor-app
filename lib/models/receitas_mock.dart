import 'package:sabor_app/models/receita.dart';

const List<Receita> receitasMock = [
  Receita(
    id: "1",
    nome: "Pao",
    categoria: "Padaria",
    origem: "Francesa",
    imagemUrl: "https://amopaocaseiro.com.br/receita/pao-de-queijo/",
    tempoMinutos: 40,
    dificuldade: Dificuldade.facil,
    ingredientes: ["Agua", "Fermento"],
    modoPreparo: "Fermentação",
    porcoes: 20,
    vegetariana: true,
  ),
  Receita(
    id: "2",
    nome: "Feijoada",
    categoria: "Almoço",
    origem: "Brasileira",
    tempoMinutos: 80,
    dificuldade: Dificuldade.media,
    ingredientes: ["Feijão", "Agua", "Linguiça", "Bacon", "Louro"],
    modoPreparo: "Cozinhamento",
  ),
];

List<Receita> filtrarPorNome(List<Receita> receitas, String termo) {
  final busca = termo.trim().toLowerCase();
  if (busca.isEmpty) return receitas;
  return receitas.where((r) => r.nome.toLowerCase().contains(busca)).toList();
}
