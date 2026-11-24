import 'package:flutter/material.dart';
import 'package:sabor_app/models/receita.dart';

class ReceitaCard extends StatelessWidget {
  final Receita receita;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ReceitaCard({
    super.key,
    required this.receita,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: receita.imagemUrl.isNotEmpty
                  ? Image.network(
                      receita.imagemUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 36,
                          child: Text(receita.nome[0].toUpperCase()),
                        );
                      },
                    )
                  : CircleAvatar(
                      radius: 36,
                      child: Text(receita.nome[0].toUpperCase()),
                    ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receita.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '${receita.categoria} · ${receita.origem}',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16),
                      const SizedBox(width: 4),
                      Text(receita.tempoFormatado),

                      const SizedBox(width: 8),

                      const Icon(Icons.signal_cellular_alt, size: 16),
                      const SizedBox(width: 4),
                      Text(receita.dificuldade.rotulo),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
