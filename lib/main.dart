import 'package:flutter/material.dart';
import 'models/demande_acte.dart';
import 'screens/liste_demandes_screen.dart';
import 'screens/detail_demande_screen.dart';
import 'screens/formulaire_demande_screen.dart';
import 'screens/a_propos_screen.dart';

void main() {
  runApp(const EtatCivilApp());
}

class EtatCivilApp extends StatelessWidget {
  const EtatCivilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'État Civil Sénégal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00853F),
          secondary: const Color(0xFFFCDD09),
          error: const Color(0xFFE03131),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00853F),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00853F),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF00853F), width: 2),
          ),
        ),
      ),
      initialRoute: '/liste',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/liste':
            return MaterialPageRoute(
              builder: (_) => const ListeDemandesScreen(),
              settings: settings,
            );
          case '/detail':
            final demande = settings.arguments as DemandeActe;
            return MaterialPageRoute(
              builder: (_) => DetailDemandeScreen(demande: demande),
              settings: settings,
            );
          case '/formulaire':
            final demande = settings.arguments as DemandeActe?;
            return MaterialPageRoute(
              builder: (_) => FormulaireDemandeScreen(demande: demande),
              settings: settings,
            );
          case '/a-propos':
            return MaterialPageRoute(
              builder: (_) => const AProposScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const ListeDemandesScreen(),
            );
        }
      },
    );
  }
}
