import 'package:flutter/material.dart';
import 'package:sabor_app/models/receitas_mock.dart';

class _HomeScreenState extends State<HomeScreen> {
  String _termo = '';
  bool _emGrade = false;

  @override
  Widget build(BuildContext context) {
    final receitas = filtrarPorNome(receitasMock, _termo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SaborApp'),
        actions: [
          IconButton(
            icon: Icon(_emGrade ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _emGrade = !_emGrade),
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO: TextField de busca
          Expanded(
            child: /* TODO: lista, grade ou estado vazio */ const SizedBox(),
          ),
        ],
      ),
    );
  }
}
