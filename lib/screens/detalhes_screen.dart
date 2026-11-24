import 'package:flutter/material.dart';
import '../models/receita.dart';

class DetalheScreen extends StatelessWidget {
  final Receita receita;

  const DetalheScreen({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Receita')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem da receita
            receita.imagemUrl.isNotEmpty
                ? Image.network(
                    receita.imagemUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _imagemFallback();
                    },
                  )
                : _imagemFallback(),

            // Nome
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                receita.nome,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Chips de informações
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _chip(receita.categoria),
                  _chip(receita.origem),
                  _chip(receita.tempoFormatado),
                  _chip(receita.dificuldade.rotulo),
                  _chip('${receita.porcoes} porções'),
                  if (receita.vegetariana) _chip('Vegetariana'),
                ],
              ),
            ),

            // Ingredientes
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Ingredientes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            ...receita.ingredientes.map(
              (ingrediente) => ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(ingrediente),
              ),
            ),

            // Modo de preparo
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Modo de preparo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                receita.modoPreparo,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),

            // Botão Favoritar
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('Favoritar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String texto) {
    return Chip(label: Text(texto));
  }

  Widget _imagemFallback() {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.orange.shade100,
      child: const Icon(Icons.restaurant, size: 100, color: Colors.orange),
    );
  }
}
