import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/demande_acte.dart';
import '../widgets/statut_badge.dart';

class DetailDemandeScreen extends StatelessWidget {
  final DemandeActe demande;
  const DetailDemandeScreen({super.key, required this.demande});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMMM yyyy');
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Détail — ${demande.demandeur}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(demande.typeActe.emoji, style: const TextStyle(fontSize: 48)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            demande.typeActe.label,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00853F),
                            ),
                          ),
                          const SizedBox(height: 6),
                          StatutBadge(delivre: demande.delivre),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoTile(icon: Icons.person, label: 'Demandeur', value: demande.demandeur),
            _InfoTile(icon: Icons.location_city, label: "Centre d'état civil", value: demande.centre),
            _InfoTile(icon: Icons.calendar_today, label: 'Date de dépôt', value: fmt.format(demande.dateDepot)),
            const SizedBox(height: 8),
            Card(
              color: demande.delaiJours > 30 ? Colors.orange.shade50 : Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined,
                        color: demande.delaiJours > 30 ? Colors.orange.shade700 : Colors.green.shade700),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Délai écoulé depuis le dépôt',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        Text(
                          '${demande.delaiJours} jour${demande.delaiJours > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: demande.delaiJours > 30 ? Colors.orange.shade700 : Colors.green.shade700,
                          ),
                        ),
                        if (demande.delaiJours > 30)
                          const Text('⚠ Délai anormalement long',
                              style: TextStyle(fontSize: 11, color: Colors.deepOrange)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00853F)),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
      ),
    );
  }
}
