import 'package:flutter/material.dart';

class AProposScreen extends StatelessWidget {
  const AProposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF00853F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.account_balance, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              "Suivi des demandes\nd'actes d'état civil",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00853F)),
            ),
            const SizedBox(height: 8),
            const Text(
              'ODD 16 — Paix, justice et institutions efficaces',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(height: 40),
            _InfoRow(icon: Icons.person, label: 'Développeur', value: 'Alpha Sy'),
            _InfoRow(icon: Icons.school, label: 'Établissement', value: 'ESMT Dakar — Promotion DAR26'),
            _InfoRow(
              icon: Icons.source,
              label: 'Source des données',
              value: 'Centres d\'état civil de Dakar-Plateau, Pikine, Rufisque et Guédiawaye',
            ),
            _InfoRow(icon: Icons.calendar_today, label: 'Date de collecte', value: 'Mai – Juin 2026'),
            _InfoRow(icon: Icons.location_on, label: 'Lieu de collecte', value: 'Dakar, Sénégal'),
            const Divider(height: 40),
            Card(
              color: const Color(0xFF00853F).withOpacity(0.07),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contexte',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00853F))),
                    SizedBox(height: 8),
                    Text(
                      'Au Sénégal, obtenir un acte de naissance peut prendre plusieurs semaines. '
                      'Les demandeurs se rendent au centre d\'état civil de leur arrondissement, '
                      'déposent leur dossier et attendent la délivrance. Cette application permet '
                      'à un centre de suivre et gérer ces demandes facilement.',
                      style: TextStyle(fontSize: 13, height: 1.5),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF00853F), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
