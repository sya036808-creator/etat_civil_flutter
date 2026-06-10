import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/demande_acte.dart';

class FormulaireDemandeScreen extends StatefulWidget {
  final DemandeActe? demande;
  const FormulaireDemandeScreen({super.key, this.demande});

  @override
  State<FormulaireDemandeScreen> createState() => _FormulaireDemandeScreenState();
}

class _FormulaireDemandeScreenState extends State<FormulaireDemandeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _demandeurCtrl;
  late final TextEditingController _centreCtrl;
  late TypeActe _typeActe;
  late DateTime _dateDepot;
  late bool _delivre;

  bool get _estEdition => widget.demande != null;

  @override
  void initState() {
    super.initState();
    _demandeurCtrl = TextEditingController(text: widget.demande?.demandeur ?? '');
    _centreCtrl = TextEditingController(text: widget.demande?.centre ?? '');
    _typeActe = widget.demande?.typeActe ?? TypeActe.naissance;
    _dateDepot = widget.demande?.dateDepot ?? DateTime.now();
    _delivre = widget.demande?.delivre ?? false;
  }

  @override
  void dispose() {
    _demandeurCtrl.dispose();
    _centreCtrl.dispose();
    super.dispose();
  }

  Future<void> _choisirDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateDepot,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateDepot = picked);
  }

  void _soumettre() {
    if (!_formKey.currentState!.validate()) return;
    final demande = DemandeActe(
      id: _estEdition
          ? widget.demande!.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
      demandeur: _demandeurCtrl.text.trim(),
      typeActe: _typeActe,
      centre: _centreCtrl.text.trim(),
      dateDepot: _dateDepot,
      delivre: _delivre,
    );
    Navigator.pop(context, demande);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(_estEdition ? 'Modifier la demande' : 'Nouvelle demande'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _demandeurCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nom du demandeur *',
                  prefixIcon: Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Le nom est obligatoire.';
                  if (v.trim().length < 3) return 'Minimum 3 caractères.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TypeActe>(
                value: _typeActe,
                decoration: const InputDecoration(
                  labelText: "Type d'acte *",
                  prefixIcon: Icon(Icons.description),
                ),
                items: TypeActe.values
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text('${t.emoji}  ${t.label}'),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _typeActe = v!),
                validator: (v) => v == null ? "Choisissez un type d'acte." : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _centreCtrl,
                decoration: const InputDecoration(
                  labelText: "Centre d'état civil *",
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'Ex. Centre État Civil de Dakar-Plateau',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Le centre est obligatoire.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _choisirDate,
                borderRadius: BorderRadius.circular(10),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date de dépôt *',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(fmt.format(_dateDepot)),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Acte délivré'),
                subtitle: Text(_delivre ? 'Demande traitée.' : 'En attente de traitement.'),
                value: _delivre,
                activeColor: const Color(0xFF00853F),
                onChanged: (v) => setState(() => _delivre = v),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _soumettre,
                icon: Icon(_estEdition ? Icons.save : Icons.add),
                label: Text(
                  _estEdition ? 'Enregistrer les modifications' : 'Créer la demande',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00853F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
