enum TypeActe { naissance, mariage, deces }

extension TypeActeLabel on TypeActe {
  String get label {
    switch (this) {
      case TypeActe.naissance: return 'Acte de naissance';
      case TypeActe.mariage:   return 'Acte de mariage';
      case TypeActe.deces:     return 'Acte de décès';
    }
  }
  String get emoji {
    switch (this) {
      case TypeActe.naissance: return '👶';
      case TypeActe.mariage:   return '💍';
      case TypeActe.deces:     return '🕊️';
    }
  }
}

class DemandeActe {
  final String id;
  final String demandeur;
  final TypeActe typeActe;
  final String centre;
  final DateTime dateDepot;
  bool delivre;

  DemandeActe({
    required this.id,
    required this.demandeur,
    required this.typeActe,
    required this.centre,
    required this.dateDepot,
    this.delivre = false,
  });

  int get delaiJours => DateTime.now().difference(dateDepot).inDays;

  DemandeActe copyWith({
    String? demandeur,
    TypeActe? typeActe,
    String? centre,
    DateTime? dateDepot,
    bool? delivre,
  }) {
    return DemandeActe(
      id: id,
      demandeur: demandeur ?? this.demandeur,
      typeActe: typeActe ?? this.typeActe,
      centre: centre ?? this.centre,
      dateDepot: dateDepot ?? this.dateDepot,
      delivre: delivre ?? this.delivre,
    );
  }
}
