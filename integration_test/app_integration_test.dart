import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_production/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Integration Flow', () {
    testWidgets('Parcours 1: Navigation entre les onglets et consultation du catalogue', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: ProductionApp()));
      await tester.pumpAndSettle();

      // Verifier lecran Catalogue initial
      expect(find.text('Catalogue Produits'), findsOneWidget);

      // Naviguer vers l onglet Panier
      await tester.tap(find.text('Panier'));
      await tester.pumpAndSettle();
      expect(find.text('Mon Panier'), findsOneWidget);

      // Naviguer vers l onglet Favoris
      await tester.tap(find.text('Favoris'));
      await tester.pumpAndSettle();
      expect(find.text('Mes Favoris'), findsOneWidget);

      // Naviguer vers l onglet Parametres
      await tester.tap(find.text('Paramètres'));
      await tester.pumpAndSettle();
      expect(find.text('Mode Sombre'), findsOneWidget);
    });

    testWidgets('Parcours 2: Changement de filtre et recherche de produit', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: ProductionApp()));
      await tester.pumpAndSettle();

      // Filtrer par High-Tech
      await tester.tap(find.text('High-Tech'));
      await tester.pumpAndSettle();

      // Saisie dans le champ de recherche
      await tester.enterText(find.byType(TextField), 'Casque');
      await tester.pumpAndSettle();

      expect(find.text('Casque Sans Fil ANC Pro'), findsOneWidget);
    });
  });
}
