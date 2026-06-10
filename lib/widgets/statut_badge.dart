import 'package:flutter/material.dart';

class StatutBadge extends StatelessWidget {
  final bool delivre;
  const StatutBadge({super.key, required this.delivre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: delivre ? Colors.green.shade100 : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: delivre ? Colors.green.shade400 : Colors.orange.shade400,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            delivre ? Icons.check_circle : Icons.hourglass_top,
            size: 14,
            color: delivre ? Colors.green.shade700 : Colors.orange.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            delivre ? 'Délivré' : 'En attente',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: delivre ? Colors.green.shade700 : Colors.orange.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
