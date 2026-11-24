import 'package:flutter/material.dart';
import 'package:sabor_app/models/receitas_mock.dart';
import 'package:sabor_app/screens/detalhes_screen.dart';
import 'package:sabor_app/widgets/receita_card.dart';
import '../models/receita.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _termo = '';
  bool _emGrade = false;
  Future<void> _abrirDetalhe(Receita receita) async {
    final favoritou = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => DetalheScreen(receita: receita)),
    );

    if (!mounted) return;

    if (favoritou == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${receita.nome} adicionada aos favoritos ❤')),
      );
    }
  }

  void _mostrarResumo(Receita receita) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resumo rápido'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Receita: ${receita.nome}'),
            const SizedBox(height: 8),
            Text('Tempo: ${receita.tempoFormatado}'),
            Text('Porções: ${receita.porcoes}'),
            Text('Ingredientes: ${receita.ingredientes.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildLista(List<Receita> receitas) {
    return ListView.builder(
      itemCount: receitas.length,
      itemBuilder: (context, index) {
        final receita = receitas[index];

        return ReceitaCard(
          receita: receita,
          onTap: () => _abrirDetalhe(receita),
          onLongPress: () => _mostrarResumo(receita),
        );
      },
    );
  }

  Widget _buildGrade(List<Receita> receitas) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemCount: receitas.length,
      itemBuilder: (context, index) {
        final receita = receitas[index];

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _abrirDetalhe(receita),
            onLongPress: () => _mostrarResumo(receita),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: receita.imagemUrl.isNotEmpty
                      ? Image.network(
                          receita.imagemUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.restaurant, size: 60);
                          },
                        )
                      : const Icon(Icons.restaurant, size: 60),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    receita.nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVazio() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 70, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'Nenhuma receita encontrada',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final receitas = filtrarPorNome(receitasMock, _termo);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SaborApp'),
        actions: [
          IconButton(
            icon: Icon(_emGrade ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _emGrade = !_emGrade;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar receita...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                setState(() {
                  _termo = valor;
                });
              },
            ),
          ),
          Expanded(
            child: receitas.isEmpty
                ? _buildVazio()
                : _emGrade
                ? _buildGrade(receitas)
                : _buildLista(receitas),
          ),
        ],
      ),
    );
  }
}
