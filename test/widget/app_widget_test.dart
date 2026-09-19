import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_production/models/product.dart';
import 'package:app_production/widgets/product_card.dart';
import 'package:app_production/screens/catalog_screen.dart';
import 'package:app_production/screens/cart_screen.dart';
import 'package:app_production/screens/favorites_screen.dart';
import 'package:app_production/screens/settings_screen.dart';

void main() {
  const testProduct = Product(
    id: 'test_1',
    name: 'Produit Widget Test',
    description: 'Description detaillee',
    price: 99.0,
    category: 'tech',
    imageUrl: 'https://example.com/test.jpg',
    rating: 4.8,
    stock: 10,
  );

  testWidgets('Widget Test 1: ProductCard affiche les infos et les semantics', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct),
          ),
        ),
      ),
    );

    expect(find.text('Produit Widget Test'), findsOneWidget);
    expect(find.text('99.00 €'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byType(Semantics), findsWidgets);
  });

  testWidgets('Widget Test 2: CatalogScreen affiche la barre de recherche et les filtres', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CatalogScreen(),
        ),
      ),
    );

    expect(find.text('Catalogue Produits'), findsOneWidget);
    expect(find.text('Rechercher un produit...'), findsOneWidget);
    expect(find.text('Tous'), findsOneWidget);
    expect(find.text('High-Tech'), findsOneWidget);
  });

  testWidgets('Widget Test 3: CartScreen affiche letat vide par defaut', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CartScreen(),
        ),
      ),
    );

    expect(find.text('Mon Panier'), findsOneWidget);
    expect(find.text('Votre panier est vide'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  });

  testWidgets('Widget Test 4: FavoritesScreen affiche le message vide', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: FavoritesScreen(),
        ),
      ),
    );

    expect(find.text('Mes Favoris'), findsOneWidget);
    expect(find.text('Aucun favori pour le moment'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('Widget Test 5: SettingsScreen affiche le switch sombre et le selecteur de langue', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Mode Sombre'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text('Langue'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
  });
}
