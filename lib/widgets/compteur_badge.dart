import 'package:flutter/material.dart';

class CompteurBadge extends StatelessWidget {
  final int nbEnAttente;
  const CompteurBadge({super.key, required this.nbEnAttente});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: nbEnAttente > 0 ? Colors.orange.shade50 : Colors.green.shade50,
        border: Border(
          bottom: BorderSide(
            color: nbEnAttente > 0 ? Colors.orange.shade200 : Colors.green.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            nbEnAttente > 0 ? Icons.hourglass_top : Icons.check_circle,
            color: nbEnAttente > 0 ? Colors.orange.shade700 : Colors.green.shade700,
            size: 22,
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: nbEnAttente > 0 ? Colors.orange.shade800 : Colors.green.shade800,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: '$nbEnAttente ',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: nbEnAttente > 1
                      ? 'demandes en attente'
                      : nbEnAttente == 1
                          ? 'demande en attente'
                          : 'toutes les demandes sont traitées ✓',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
