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
  Receita(
    id: "3",
    nome: "Pizza",
    categoria: "Jantar",
    origem: "Italiana",
    tempoMinutos: 50,
    dificuldade: Dificuldade.media,
    ingredientes: ["Farinha", "Queijo", "Molho de tomate", "Tomate"],
    modoPreparo: "Preparar a massa, adicionar os ingredientes e assar.",
    porcoes: 8,
    vegetariana: true,
  ),
  Receita(
    id: "4",
    nome: "Lasanha",
    categoria: "Almoço",
    origem: "Italiana",
    tempoMinutos: 60,
    dificuldade: Dificuldade.media,
    ingredientes: ["Massa", "Queijo", "Presunto", "Molho de tomate"],
    modoPreparo: "Montar as camadas e levar ao forno.",
    porcoes: 6,
    vegetariana: false,
  ),
  Receita(
    id: "5",
    nome: "Brigadeiro",
    categoria: "Sobremesa",
    origem: "Brasileira",
    tempoMinutos: 30,
    dificuldade: Dificuldade.facil,
    ingredientes: ["Leite condensado", "Chocolate", "Manteiga", "Granulado"],
    modoPreparo: "Misturar os ingredientes no fogo até engrossar.",
    porcoes: 20,
    vegetariana: true,
  ),
  Receita(
    id: "6",
    nome: "Pão de Queijo",
    categoria: "Lanche",
    origem: "Brasileira",
    tempoMinutos: 35,
    dificuldade: Dificuldade.facil,
    ingredientes: ["Polvilho", "Queijo", "Leite", "Ovos"],
    modoPreparo: "Misturar os ingredientes, modelar e assar.",
    porcoes: 15,
    vegetariana: true,
  ),
];

List<Receita> filtrarPorNome(List<Receita> receitas, String termo) {
  final busca = termo.trim().toLowerCase();
  if (busca.isEmpty) return receitas;
  return receitas.where((r) => r.nome.toLowerCase().contains(busca)).toList();
}
