import 'package:flutter/material.dart';
import '../models/demande_acte.dart';
import '../widgets/demande_card.dart';
import '../widgets/compteur_badge.dart';

class ListeDemandesScreen extends StatefulWidget {
  const ListeDemandesScreen({super.key});

  @override
  State<ListeDemandesScreen> createState() => _ListeDemandesScreenState();
}

class _ListeDemandesScreenState extends State<ListeDemandesScreen> {
  final List<DemandeActe> _toutesLesDemandes = [
    DemandeActe(
      id: '1',
      demandeur: 'Moussa Diallo',
      typeActe: TypeActe.naissance,
      centre: 'Centre État Civil de Dakar-Plateau',
      dateDepot: DateTime(2026, 5, 10),
      delivre: true,
    ),
    DemandeActe(
      id: '2',
      demandeur: 'Fatou Ndiaye',
      typeActe: TypeActe.mariage,
      centre: 'Centre État Civil de Pikine',
      dateDepot: DateTime(2026, 5, 20),
      delivre: false,
    ),
    DemandeActe(
      id: '3',
      demandeur: 'Ibrahima Sow',
      typeActe: TypeActe.deces,
      centre: 'Centre État Civil de Rufisque',
      dateDepot: DateTime(2026, 4, 28),
      delivre: true,
    ),
    DemandeActe(
      id: '4',
      demandeur: 'Aminata Cissé',
      typeActe: TypeActe.naissance,
      centre: 'Centre État Civil de Guédiawaye',
      dateDepot: DateTime(2026, 5, 30),
      delivre: false,
    ),
    DemandeActe(
      id: '5',
      demandeur: 'Omar Sarr',
      typeActe: TypeActe.naissance,
      centre: 'Centre État Civil de Thiès',
      dateDepot: DateTime(2026, 6, 1),
      delivre: false,
    ),
  ];

  bool _filtrerEnAttente = false;

  List<DemandeActe> get _demandesAffichees {
    if (_filtrerEnAttente) {
      return _toutesLesDemandes.where((d) => !d.delivre).toList();
    }
    return List.from(_toutesLesDemandes);
  }

  int get _nbEnAttente => _toutesLesDemandes.where((d) => !d.delivre).length;

  Future<void> _ajouterDemande() async {
    final nouvelle = await Navigator.pushNamed(context, '/formulaire') as DemandeActe?;
    if (nouvelle != null) {
      setState(() => _toutesLesDemandes.add(nouvelle));
    }
  }

  Future<void> _modifierDemande(DemandeActe demande) async {
    final modifiee = await Navigator.pushNamed(
      context, '/formulaire', arguments: demande,
    ) as DemandeActe?;
    if (modifiee != null) {
      setState(() {
        final index = _toutesLesDemandes.indexWhere((d) => d.id == modifiee.id);
        if (index != -1) _toutesLesDemandes[index] = modifiee;
      });
    }
  }

  Future<void> _supprimerDemande(DemandeActe demande) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text('Supprimer la demande de ${demande.demandeur} ?\nCette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (confirme == true) {
      setState(() => _toutesLesDemandes.removeWhere((d) => d.id == demande.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Demande de ${demande.demandeur} supprimée.'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final demandes = _demandesAffichees;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demandes d'actes d'état civil"),
        actions: [
          IconButton(
            icon: Icon(
              _filtrerEnAttente ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: _filtrerEnAttente ? const Color(0xFFFCDD09) : Colors.white,
            ),
            tooltip: _filtrerEnAttente ? 'Afficher tout' : 'Filtrer : en attente',
            onPressed: () => setState(() => _filtrerEnAttente = !_filtrerEnAttente),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'À propos',
            onPressed: () => Navigator.pushNamed(context, '/a-propos'),
          ),
        ],
      ),
      body: Column(
        children: [
          CompteurBadge(nbEnAttente: _nbEnAttente),
          if (_filtrerEnAttente)
            Container(
              width: double.infinity,
              color: const Color(0xFFFCDD09).withOpacity(0.2),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16, color: Color(0xFF00853F)),
                  const SizedBox(width: 6),
                  Text('Filtre actif : en attente uniquement',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                ],
              ),
            ),
          Expanded(
            child: demandes.isEmpty
                ? const Center(
                    child: Text('Aucune demande trouvée.',
                        style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    itemCount: demandes.length,
                    itemBuilder: (ctx, i) {
                      final d = demandes[i];
                      return DemandeCard(
                        demande: d,
                        onTap: () => Navigator.pushNamed(context, '/detail', arguments: d),
                        onEdit: () => _modifierDemande(d),
                        onDelete: () => _supprimerDemande(d),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _ajouterDemande,
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle demande'),
      ),
    );
  }
}
